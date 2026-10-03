SET search_path TO public;

COPY customers
FROM 'C:\Users\armmy\Desktop\DA Courses\Project_brazil\csv_files\olist_customers_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY sellers
FROM 'C:\Users\armmy\Desktop\DA Courses\Project_brazil\csv_files\olist_sellers_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY product_category_name_translations
FROM 'C:\Users\armmy\Desktop\DA Courses\Project_brazil\csv_files\product_category_name_translation.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY geolocation
FROM 'C:\Users\armmy\Desktop\DA Courses\Project_brazil\csv_files\olist_geolocation_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY products
FROM 'C:\Users\armmy\Desktop\DA Courses\Project_brazil\csv_files\olist_products_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY orders
FROM 'C:\Users\armmy\Desktop\DA Courses\Project_brazil\csv_files\olist_orders_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY order_payments
FROM 'C:\Users\armmy\Desktop\DA Courses\Project_brazil\csv_files\olist_order_payments_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY order_reviews
FROM 'C:\Users\armmy\Desktop\DA Courses\Project_brazil\csv_files\olist_order_reviews_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY order_items
FROM 'C:\Users\armmy\Desktop\DA Courses\Project_brazil\csv_files\olist_order_items_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
