USE [base_esteban];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

IF OBJECT_ID(N'silver.products', N'U') IS NOT NULL
    DROP TABLE silver.products;
GO

CREATE TABLE silver.products
(
    product_id                       varchar(100) NULL,
    product_category_name            varchar(100) NULL,
    product_category_name_english    varchar(100) NULL,
    product_name_length              int NULL,
    product_description_length       int NULL,
    product_photos_qty               int NULL,
    product_weight_g                 int NULL,
    product_length_cm                int NULL,
    product_height_cm                int NULL,
    product_width_cm                 int NULL
);
GO
