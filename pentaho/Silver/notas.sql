-- SELECTS genéricos
SELECT TOP 100 *
FROM bronze.budget_2018;

SELECT TOP 100 *
FROM bronze.campaign_calendar;

SELECT TOP 100 *
FROM bronze.categories;

SELECT TOP 100 *
FROM bronze.order_items;

SELECT TOP 100 *
FROM bronze.orders;

SELECT TOP 100 *
FROM bronze.product_category_name_translation;

SELECT TOP 100 *
FROM bronze.products;

SELECT TOP 100 *
FROM bronze.regions;

-- Pruebas para limpieza

SELECT *
FROM bronze.products p
	INNER JOIN bronze.product_category_name_translation ptra ON p.product_category_name = ptra.product_category_name
	INNER JOIN bronze.categories c ON ptra.product_category_name_english = c.olist_category --32328


SELECT *
FROM bronze.products p
	INNER JOIN bronze.order_items o ON o.product_id = p.product_id
WHERE p.product_category_name IS NULL --1603

SELECT *
FROM bronze.categories c
WHERE c.budget_category IS NULL OR c.olist_category IS NULL

---------------------------------

SELECT COUNT (*)
FROM bronze.products --32951