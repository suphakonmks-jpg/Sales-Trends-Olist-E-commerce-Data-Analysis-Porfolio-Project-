-- create staging table for cleaning check
drop table if exists order_payments_staging;

SET search_path TO public;

create table order_payments_staging
(like order_payments);

insert into order_payments_staging
select *
from order_payments;

-- 1.Check Standardize

select count(*)
from order_payments_staging
;

select count(distinct order_id)
from order_payments_staging
;

select count(distinct payment_sequential)
from order_payments_staging;

select count(distinct payment_type)
from order_payments_staging;

select count(distinct payment_installments)
from order_payments_staging;

select count(distinct payment_value)
from order_payments_staging;


-- 2.Check Null Value or blank values

select *
from order_payments_staging
where order_id is null;

select *
from order_payments_staging
where payment_sequential is null;

select *
from order_payments_staging
where payment_type is null;

select *
from order_payments_staging
where payment_installments is null;

select *
from order_payments_staging
where payment_value is null;

-- 2.Check duplicates
WITH check_dup as
(
    select 
        *,
        row_number() 
        over(PARTITION BY 
        order_id,
        payment_sequential,
        payment_type,
        payment_installments,
        payment_value
        ) as dup
    from order_payments_staging
)

SELECT *
from check_dup
where dup >1;