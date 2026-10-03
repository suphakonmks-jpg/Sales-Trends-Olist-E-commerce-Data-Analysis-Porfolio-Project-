-- create staging table for cleaning check
drop table if exists order_items_staging;

SET search_path TO public;

create table order_items_staging
(like order_items);

insert into order_items_staging
select *
from order_items;

-- 1.Check Standardize

select count(*)
from order_items_staging;

select count(distinct order_id)
from order_items_staging;

select count(distinct order_item_id)
from order_items_staging;

select count(distinct product_id)
from order_items_staging;

select count(distinct seller_id)
from order_items_staging;

select count(distinct shipping_limit_date)
from order_items_staging;

select count(distinct price)
from order_items_staging;

select count(distinct freight_value)
from order_items_staging;


-- 2.Check Null Value or blank values

select *
from order_items_staging
where order_id is null;

select *
from order_items_staging
where order_item_id is null;

select *
from order_items_staging
where product_id is null;

select *
from order_items_staging
where seller_id is null;

select *
from order_items_staging
where shipping_limit_date is null;

select *
from order_items_staging
where price is null;

select *
from order_items_staging
where freight_value is null;

-- 2.Check duplicates
WITH check_dup as
(
    select 
        *,
        row_number() 
        over(PARTITION BY 
        order_id,
        order_item_id,
        product_id,
        seller_id,
        shipping_limit_date,
        price,
        freight_value
        ) as dup
    from order_items_staging
)

SELECT *
from check_dup
where dup >1;