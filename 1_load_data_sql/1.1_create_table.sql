drop table if exists order_items;
drop table if exists order_reviews;
drop table if exists order_payments;
drop table if exists orders;
drop table if exists geolocation;
drop table if exists products;
drop table if exists product_category_name_translations;
drop table if exists sellers;
drop table if exists customers;

SET search_path TO public;

create table customers
(
    customer_id                 varchar,
    customer_unique_id          varchar,
    customer_zip_code_prefix    integer,
    customer_city               varchar,
    customer_state              varchar,
    PRIMARY KEY (customer_id)
);

create table sellers
(
    seller_id                       varchar,
    seller_zip_code_prefix          int,
    seller_city                     varchar,
    seller_state                    varchar,
    PRIMARY KEY (seller_id)
);

create table product_category_name_translations
(
    product_category_name           VARCHAR,
    product_category_name_english   varchar,
    PRIMARY KEY (product_category_name)
);


create table geolocation
(
    geolocation_zip_code_prefix     integer,
    geolocation_lat                 numeric,
    geolocation_lng                 numeric,
    geolocation_city                varchar,
    geolocation_state               varchar
);

create table products
(
    product_id                      varchar,
    product_category_name           varchar,
    product_name_lenght             int,
    product_description_lenght      int,
    product_photos_qty              int,
    product_weight_g                int,
    product_length_cm               int,
    product_height_cm               int,
    product_width_cm                int,
    PRIMARY KEY (product_id)
);


create table orders
(
    order_id                        varchar,
    customer_id                     varchar,
    order_status                    varchar,
    order_purchase_timestamp        TIMESTAMP,
    order_approved_at               TIMESTAMP,
    order_delivered_carrier_date    TIMESTAMP,
    order_delivered_customer_date   TIMESTAMP,
    order_estimated_delivery_date   TIMESTAMP,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);


create table order_payments
(
    order_id                        varchar,
    payment_sequential              int,
    payment_type                    varchar,
    payment_installments            int,
    payment_value                   numeric,
    PRIMARY KEY (order_id,payment_sequential),
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

create table order_reviews
(
    review_id                       varchar,
    order_id                        varchar,
    review_score                    int,
    review_comment_title            varchar,
    review_comment_message          varchar,
    review_creation_date            TIMESTAMP,
    review_answer_timestamp         TIMESTAMP,
    PRIMARY KEY (review_id,order_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

create table order_items
(
    order_id                        varchar,
    order_item_id                   int,
    product_id                      varchar,
    seller_id                       varchar,
    shipping_limit_date             TIMESTAMP,
    price                           numeric,
    freight_value                   numeric,
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id),
    FOREIGN KEY (seller_id) REFERENCES sellers (seller_id)
);



CREATE INDEX idx_orders_customer_id ON orders (customer_id);
CREATE INDEX idx_order_payments_order_id ON order_payments (order_id);
CREATE INDEX idx_order_reviews_order_id ON order_reviews (order_id);
CREATE INDEX idx_order_items_order_id ON order_items (order_id);
CREATE INDEX idx_order_items_product_id ON order_items (product_id);
CREATE INDEX idx_order_items_seller_id ON order_items (seller_id);

-- SELECT table_name 
-- FROM information_schema.tables 
-- WHERE table_schema = 'public';

