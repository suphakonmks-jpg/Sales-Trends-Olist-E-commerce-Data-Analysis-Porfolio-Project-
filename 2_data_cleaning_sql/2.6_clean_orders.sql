-- create staging table for cleaning check
drop table if exists orders_staging;

SET search_path TO public;

create table orders_staging
(like orders);

insert into orders_staging
select *
from orders;

-- 1.Check Standardize

select count(*)
from orders_staging
;

select count(distinct order_id)
from orders_staging
;

select count(distinct customer_id)
from orders_staging;

select count(distinct order_status)
from orders_staging;

select count(distinct order_purchase_timestamp)
from orders_staging;

select count(distinct order_approved_at)
from orders_staging;

select count(distinct order_delivered_carrier_date)
from orders_staging;

select count(distinct order_delivered_customer_date)
from orders_staging;

select count(distinct order_estimated_delivery_date)
from orders_staging;

-- 2.Check Null Value or blank values

select *
from orders_staging
where order_id is null;

select *
from orders_staging
where customer_id is null;

select *
from orders_staging
where order_status is null;

select *
from orders_staging
where order_purchase_timestamp is null;

select *
from orders_staging
where order_approved_at is null;

select *
from orders_staging
where order_delivered_carrier_date is null;

select *
from orders_staging
where order_delivered_customer_date is null;

select *
from orders_staging
where order_estimated_delivery_date is null;

-- 2.Check duplicates
WITH check_dup as
(
    select 
        *,
        row_number() 
        over(PARTITION BY 
        order_id,
        customer_id,
        order_status,
        order_purchase_timestamp,
        order_approved_at,
        order_delivered_carrier_date,
        order_delivered_customer_date,
        order_estimated_delivery_date
        ) as dup
    from orders_staging
)

SELECT *
from check_dup
where dup >1;



