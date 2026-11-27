"""
db_utils.py - Utilidades para conectarse a SQL Server local desde Python.

Requisitos:
    pip install sqlalchemy pyodbc pandas python-dotenv
    + "ODBC Driver 17 (o 18) for SQL Server" instalado en Windows

Configuración: crear un archivo .env junto a este script (y agregarlo a .gitignore):

    DB_SERVER=localhost          # o localhost\\SQLEXPRESS si usás una instancia con nombre
    DB_NAME=base
    DB_DRIVER=ODBC Driver 17 for SQL Server
    DB_TRUSTED=yes               # yes = autenticación de Windows; no = usuario/contraseña
    DB_USER=
    DB_PASS=

Uso:
    from db_utils import get_engine, read_sql, write_df, execute

    df = read_sql("SELECT TOP 10 * FROM bronze.sap_kna1_customers")
    write_df(df, "customers", schema="silver", if_exists="replace")
    execute("TRUNCATE TABLE silver.customers")
"""

import os
from urllib.parse import quote_plus

import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.engine import Engine

load_dotenv()

_engine: Engine | None = None


def get_engine() -> Engine:
    """Devuelve un engine de SQLAlchemy (se crea una sola vez y se reutiliza)."""
    global _engine
    if _engine is not None:
        return _engine

    server = os.getenv("DB_SERVER", "localhost")
    database = os.getenv("DB_NAME", "master")
    driver = os.getenv("DB_DRIVER", "ODBC Driver 17 for SQL Server")
    trusted = os.getenv("DB_TRUSTED", "yes").lower() in ("yes", "true", "1")

    conn_str = f"DRIVER={{{driver}}};SERVER={server};DATABASE={database};"
    if trusted:
        conn_str += "Trusted_Connection=yes;"
    else:
        conn_str += f"UID={os.getenv('DB_USER')};PWD={os.getenv('DB_PASS')};"
    # El driver 18 exige cifrado por defecto; en local evita el error de certificado
    conn_str += "TrustServerCertificate=yes;"

    _engine = create_engine(
        f"mssql+pyodbc:///?odbc_connect={quote_plus(conn_str)}",
        fast_executemany=True,  # inserts masivos mucho más rápidos
    )
    return _engine


def read_sql(query: str, params: dict | None = None) -> pd.DataFrame:
    """Ejecuta un SELECT y devuelve un DataFrame. Parámetros con :nombre."""
    with get_engine().connect() as conn:
        return pd.read_sql(text(query), conn, params=params)


def write_df(
    df: pd.DataFrame,
    table: str,
    schema: str = "dbo",
    if_exists: str = "append",  # 'append' | 'replace' | 'fail'
    chunksize: int = 10_000,
) -> None:
    """Escribe un DataFrame en una tabla."""
    df.to_sql(
        table,
        get_engine(),
        schema=schema,
        if_exists=if_exists,
        index=False,
        chunksize=chunksize,
    )
    print(f"{len(df):,} filas escritas en {schema}.{table}")


def execute(sql: str, params: dict | None = None) -> None:
    """Ejecuta una sentencia sin resultado (CREATE, INSERT, UPDATE, TRUNCATE...) con commit."""
    with get_engine().begin() as conn:
        conn.execute(text(sql), params or {})


def create_schema(name: str) -> None:
    """Crea un esquema si no existe (ej: bronze, silver, gold)."""
    execute(
        f"IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = :n) "
        f"EXEC('CREATE SCHEMA [{name}]')",
        {"n": name},
    )


def test_connection() -> None:
    """Prueba rápida de conexión."""
    df = read_sql("SELECT @@SERVERNAME AS servidor, DB_NAME() AS base, @@VERSION AS version")
    print(df.T.to_string(header=False))


if __name__ == "__main__":
    test_connection()