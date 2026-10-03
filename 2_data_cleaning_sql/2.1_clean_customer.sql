-- create staging table for cleaning check
drop table if exists customers_staging;

SET search_path TO public;

create table customers_staging
(like customers);

insert into customers_staging
select *
from customers;


-- 1.Check Standardize

select count(*)
from customers_staging
;

select count(distinct customer_id)
from customers_staging
;

select count(distinct customer_unique_id)
from customers_staging;

select count(distinct customer_zip_code_prefix)
from customers_staging;

select count(distinct customer_city)
from customers_staging;

select count(distinct customer_state)
from customers_staging;

-- 2.Check Null Value or blank values

select *
from customers_staging
where customer_id is null;

select *
from customers_staging
where customer_unique_id is null;

select *
from customers_staging
where customer_zip_code_prefix is null;

select *
from customers_staging
where customer_city is null;

select *
from customers_staging
where customer_state is null;

-- 2.Check duplicates
WITH check_dup as
(
    select 
        *,
        row_number() over(PARTITION BY customer_id,customer_unique_id,customer_zip_code_prefix,customer_city,customer_state) as dup
    from customers_staging
)

SELECT *
from check_dup
where dup >1;