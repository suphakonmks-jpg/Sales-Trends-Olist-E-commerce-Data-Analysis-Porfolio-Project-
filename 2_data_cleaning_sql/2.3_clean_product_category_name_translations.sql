-- create staging table for cleaning check
drop table if exists product_category_name_translations_staging;

SET search_path TO public;

create table product_category_name_translations_staging
(like product_category_name_translations);

insert into product_category_name_translations_staging
select *
from product_category_name_translations;

-- 1.Check Standardize

select count(*)
from product_category_name_translations_staging
;

select count(distinct product_category_name)
from product_category_name_translations_staging
;

select count(distinct product_category_name_english)
from product_category_name_translations_staging;


-- 2.Check Null Value or blank values

select *
from product_category_name_translations_staging
where product_category_name is null;

select *
from product_category_name_translations_staging
where product_category_name_english is null;

-- 2.Check duplicates
WITH check_dup as
(
    select 
        *,
        row_number() over(PARTITION BY product_category_name,product_category_name_english) as dup
    from product_category_name_translations_staging
)

SELECT *
from check_dup
where dup >1;