-- create staging table for cleaning check
drop table if exists products_staging;

SET search_path TO public;

create table products_staging
(like products);

insert into products_staging
select *
from products;

-- 1.Check Standardize

select count(*)
from products_staging
;

select count(distinct product_id)
from products_staging;

select count(distinct product_category_name)
from products_staging;

select count(distinct product_name_lenght)
from products_staging;

select count(distinct product_description_lenght)
from products_staging;

select count(distinct product_photos_qty)
from products_staging;

select count(distinct product_weight_g)
from products_staging;

select count(distinct product_length_cm)
from products_staging;

select count(distinct product_height_cm)
from products_staging;

select count(distinct product_width_cm)
from products_staging;


-- 2.Check Null Value or blank values

select *
from products_staging
where product_id is null;

select *
from products_staging
where product_category_name is null;

select *
from products_staging
where product_name_lenght is null;

select *
from products_staging
where product_description_lenght is null;

select *
from products_staging
where product_photos_qty is null;

select *
from products_staging
where product_weight_g is null;

select *
from products_staging
where product_length_cm is null;

select *
from products_staging
where product_height_cm is null;

select *
from products_staging
where product_width_cm is null;

-- 2.Check duplicates
WITH check_dup as
(
    select 
        *,
        row_number() 
        over(PARTITION BY 
        product_id,
        product_category_name,
        product_name_lenght,
        product_description_lenght,
        product_photos_qty,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm
        ) as dup
    from products_staging
)

SELECT *
from check_dup
where dup >1;


