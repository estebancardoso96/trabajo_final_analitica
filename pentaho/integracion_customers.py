from db_utils import read_sql
from db_utils import write_df
import pandas as pd
import numpy as np

customer_sap = read_sql("SELECT * FROM bronze.sap_customers")
customer_olist = read_sql("SELECT * FROM bronze.olist_customers")

print(f"\nDimensiones del dataset: {customer_olist.shape[0]} filas × {customer_olist.shape[1]} columnas\n")
audit_olist = pd.DataFrame({
    'dtype':          customer_olist.dtypes,
    'nulos':          customer_olist.isnull().sum(),
    'pct_nulos':      (customer_olist.isnull().sum() / len(customer_olist) * 100).round(2),
    'valores_únicos': customer_olist.nunique(),
    'moda':           customer_olist.mode().iloc[0], # Extrae la primera fila de la moda
    'ejemplo':        customer_olist.sample(1).iloc[0], # Genera muestra aleatoria y extrae primera fila
    })
audit_olist

print(f"\nDimensiones del dataset: {customer_sap.shape[0]} filas × {customer_sap.shape[1]} columnas\n")
audit_sap = pd.DataFrame({
    'dtype':          customer_sap.dtypes,
    'nulos':          customer_sap.isnull().sum(),
    'pct_nulos':      (customer_sap.isnull().sum() / len(customer_sap) * 100).round(2),
    'valores_únicos': customer_sap.nunique(),
    'moda':           customer_sap.mode().iloc[0], # Extrae la primera fila de la moda
    'ejemplo':        customer_sap.sample(1).iloc[0], # Genera muestra aleatoria y extrae primera fila
    })
audit_sap

customer_sap = customer_sap.drop(columns = {'LAND1', 'MANDT', 'STCD1'})
sap_olist = customer_sap.merge(customer_olist, how='inner', left_on=['KUNNR'], right_on=['customer_id'])[['customer_id','REGIO', 'customer_state', 'PSTLZ','customer_zip_code_prefix',
                                                                                              'ORT01', 'customer_city']]

sap_olist['ORT01'] = sap_olist['ORT01'].str.lower()

sap_olist['bool_zip'] = sap_olist['customer_zip_code_prefix'] == sap_olist['PSTLZ']
sap_olist['bool_city'] = sap_olist['ORT01'] == sap_olist['customer_city']

print(sap_olist.groupby('bool_zip').size().reset_index(name ='cantidad'))
print(sap_olist.groupby('bool_city').size().reset_index(name ='cantidad'))


sap_olist = sap_olist.drop(columns = {'PSTLZ', 'ORT01', 'bool_zip', 'bool_city'})
sap_olist['customer_state_new'] = np.where(sap_olist['customer_state'].isna(), sap_olist['REGIO'], sap_olist['customer_state'])
sap_olist = sap_olist.drop(columns={'customer_state', 'REGIO'}).rename(columns={'customer_state_new':'customer_state'})

anti_sap = customer_sap[~customer_sap['KUNNR'].isin(customer_olist['customer_id'])]
anti_sap['ORT01'] = anti_sap['ORT01'].str.lower()
equivalencias = {'ORT01':'customer_city', 'PSTLZ':'customer_zip_code_prefix', 'REGIO':'customer_state', 'KUNNR':'customer_id'}
anti_sap.columns = anti_sap.columns.map(equivalencias)

anti_olist = customer_olist[~customer_olist['customer_id'].isin(customer_sap['KUNNR'])]


customer_final = pd.concat([sap_olist, anti_olist, anti_sap])

write_df(customer_final, "customers", schema="silver", if_exists="replace")