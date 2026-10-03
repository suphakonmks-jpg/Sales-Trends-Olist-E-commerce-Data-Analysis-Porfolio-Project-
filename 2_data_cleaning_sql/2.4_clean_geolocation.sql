-- create staging table for cleaning check
drop table if exists geolocation_staging;

SET search_path TO public;

create table geolocation_staging
(like geolocation);

insert into geolocation_staging
select *
from geolocation;

-- 1.Check Standardize

select count(*)
from geolocation_staging
;

select count(distinct geolocation_zip_code_prefix)
from geolocation_staging;

select count(distinct geolocation_lat)
from geolocation_staging;

select count(distinct geolocation_lng)
from geolocation_staging;

select count(distinct geolocation_city)
from geolocation_staging;

select count(distinct geolocation_state)
from geolocation_staging;


-- 2.Check Null Value or blank values

select *
from geolocation_staging
where geolocation_zip_code_prefix is null;

select *
from geolocation_staging
where geolocation_lat is null;

select *
from geolocation_staging
where geolocation_lng is null;

select *
from geolocation_staging
where geolocation_city is null;

select *
from geolocation_staging
where geolocation_state is null;

-- 2.Check duplicates
WITH check_dup as
(
    select 
        *,
        row_number() over(PARTITION BY geolocation_zip_code_prefix,geolocation_lat,geolocation_lng,geolocation_city,geolocation_state) as dup
    from geolocation_staging
)

SELECT *
from check_dup
where dup >1;