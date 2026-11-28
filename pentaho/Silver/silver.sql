USE [base_esteban];
GO

/*
    Silver - categorías
    Recarga silver.categories desde Bronze. No modifica silver.customers
    ni pentaho/Silver/notas.sql.
*/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'silver.categories', N'U') IS NOT NULL
    DROP TABLE silver.categories;
GO

CREATE TABLE silver.categories
(
    olist_category                 varchar(100) NULL,
    product_category_name_english varchar(100) NULL,
    budget_category               varchar(100) NULL
);
GO

INSERT INTO silver.categories
(
    olist_category,
    product_category_name_english,
    budget_category
)
SELECT
    t.product_category_name,
    c.olist_category,
    NULLIF(LTRIM(RTRIM(c.budget_category)), '')
FROM bronze.categories AS c
    LEFT JOIN bronze.product_category_name_translation AS t ON c.olist_category = t.product_category_name_english
WHERE NULLIF(LTRIM(RTRIM(c.olist_category)), '') IS NOT NULL;
GO

/* Completa las traducciones disponibles en Bronze. */
UPDATE sc
SET sc.product_category_name_english =
    NULLIF(LTRIM(RTRIM(t.product_category_name_english)), '')
FROM silver.categories AS sc
INNER JOIN bronze.product_category_name_translation AS t
    ON LTRIM(RTRIM(t.product_category_name_english)) = sc.olist_category;
GO

UPDATE silver.categories
SET olist_category = product_category_name_english
WHERE olist_category IS NULL;

UPDATE silver.categories
SET product_category_name_english = 'portable_kitchen_and_food_preparation_devices'
WHERE olist_category = 'portateis_cozinha_e_preparadores_de_alimentos';
GO
