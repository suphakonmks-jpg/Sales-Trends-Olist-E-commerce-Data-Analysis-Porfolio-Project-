-- create staging table for cleaning check
drop table if exists sellers_staging;

SET search_path TO public;

create table sellers_staging
(like sellers);

insert into sellers_staging
select *
from sellers;

-- 1.Check Standardize

select count(*)
from sellers_staging
;

select count(distinct seller_id)
from sellers_staging
;

select count(distinct seller_zip_code_prefix)
from sellers_staging;

select count(distinct seller_city)
from sellers_staging;

select count(distinct seller_state)
from sellers_staging;


-- 2.Check Null Value or blank values

select *
from sellers_staging
where seller_id is null;

select *
from sellers_staging
where seller_zip_code_prefix is null;

select *
from sellers_staging
where seller_city is null;

select *
from sellers_staging
where seller_state is null;

-- 2.Check duplicates
WITH check_dup as
(
    select 
        *,
        row_number() over(PARTITION BY seller_id,seller_zip_code_prefix,seller_city,seller_state) as dup
    from sellers_staging
)

SELECT *
from check_dup
where dup >1;