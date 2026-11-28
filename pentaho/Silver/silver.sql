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
    NULLIF(LTRIM(RTRIM(t.product_category_name)), ''),
    NULLIF(LTRIM(RTRIM(c.olist_category)), ''),
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

INSERT INTO silver.categories([olist_category], [product_category_name_english], [budget_category])
VALUES ('Others','Others','Others')

GO

/* PRODUCTS */

IF OBJECT_ID(N'silver.products', N'U') IS NOT NULL
    DROP TABLE silver.products;
GO

CREATE TABLE silver.products
(
    product_id                       varchar(100) NULL,
    product_category_name            varchar(100) NULL,
    product_name_length              int NULL,
    product_description_length       int NULL,
    product_photos_qty               int NULL,
    product_weight_g                 int NULL,
    product_length_cm                int NULL,
    product_height_cm                int NULL,
    product_width_cm                 int NULL
);

INSERT INTO silver.products
(
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
SELECT
    p.product_id,
    NULLIF(LTRIM(RTRIM(p.product_category_name)), ''),
    p.product_name_lenght,
    p.product_description_lenght,
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM bronze.products AS p
GO

UPDATE silver.products
SET product_category_name = 'Others'
WHERE product_category_name IS NULL;
GO

/* BUDGET 2018 */

IF OBJECT_ID(N'silver.budget2018', N'U') IS NOT NULL
    DROP TABLE silver.budget2018;
GO

CREATE TABLE [silver].[budget2018]
(
    [region]     varchar(50) NULL,
    [category]   varchar(100) NULL,
    [jan]        decimal(12, 3) NULL,
    [feb]        decimal(12, 3) NULL,
    [mar]        decimal(12, 3) NULL,
    [apr]        decimal(12, 3) NULL,
    [may]        decimal(12, 3) NULL,
    [jun]        decimal(12, 3) NULL,
    [jul]        decimal(12, 3) NULL,
    [aug]        decimal(12, 3) NULL,
    [sep]        decimal(12, 3) NULL,
    [oct]        decimal(12, 3) NULL,
    [nov]        decimal(12, 3) NULL,
    [dec]        decimal(12, 3) NULL,
    [total_2018] decimal(12, 3) NULL
);
GO

INSERT INTO [silver].[budget2018]
(
    [region],
    [category],
    [jan],
    [feb],
    [mar],
    [apr],
    [may],
    [jun],
    [jul],
    [aug],
    [sep],
    [oct],
    [nov],
    [dec],
    [total_2018]
)
SELECT
    [region],
    [category],
    [jan],
    [feb],
    [mar],
    [apr],
    [may],
    [jun],
    [jul],
    [aug],
    [sep],
    [oct],
    [nov],
    [dec],
    [total_2018]
FROM [bronze].[budget_2018]
WHERE LTRIM(RTRIM([version])) = 'V2 Final';
GO

/* CAMPAIGN CALENDAR */

IF OBJECT_ID(N'silver.campaign_calendar', N'U') IS NOT NULL
    DROP TABLE silver.campaign_calendar;
GO

CREATE TABLE [silver].[campaign_calendar]
(
    [campaign_id]   varchar(20) NOT NULL,
    [campaign_name] varchar(100) NULL,
    [campaign_type] varchar(30) NULL,
    [start_date]    date NOT NULL,
    [end_date]      date NOT NULL,
    CONSTRAINT [PK_silver_campaign_calendar] PRIMARY KEY ([campaign_id])
);
GO

INSERT INTO [silver].[campaign_calendar]
(
    [campaign_id],
    [campaign_name],
    [campaign_type],
    [start_date],
    [end_date]
)
SELECT
    LTRIM(RTRIM([campaign_id])),
    NULLIF(LTRIM(RTRIM([campaign_name])), ''),
    NULLIF(LTRIM(RTRIM([campaign_type])), ''),
    [start_date],
    [end_date]
FROM [bronze].[campaign_calendar]
WHERE NULLIF(LTRIM(RTRIM([campaign_id])), '') IS NOT NULL
  AND [start_date] IS NOT NULL
  AND [end_date] > [start_date];
GO

/* REGIONS */

IF OBJECT_ID(N'silver.regions', N'U') IS NOT NULL
    DROP TABLE silver.regions;
GO

CREATE TABLE [silver].[regions]
(
    [state]  varchar(50) NULL,
    [region] varchar(50) NULL
);
GO

INSERT INTO [silver].[regions]
(
    [state],
    [region]
)
SELECT
    NULLIF(LTRIM(RTRIM([state])), ''),
    NULLIF(LTRIM(RTRIM([region])), '')
FROM [bronze].[regions];
GO
