-- create staging table for cleaning check
drop table if exists order_reviews_staging;

SET search_path TO public;

create table order_reviews_staging
(like order_reviews);

insert into order_reviews_staging
select *
from order_reviews;

-- 1.Check Standardize

select count(*)
from order_reviews_staging;

select count(distinct review_id)
from order_reviews_staging;

select count(distinct order_id)
from order_reviews_staging;

select count(distinct review_score)
from order_reviews_staging;

select count(distinct review_comment_title)
from order_reviews_staging;

select count(distinct review_comment_message)
from order_reviews_staging;

select count(distinct review_creation_date)
from order_reviews_staging;

select count(distinct review_answer_timestamp)
from order_reviews_staging;


-- 2.Check Null Value or blank values

select *
from order_reviews_staging
where review_id is null;

select *
from order_reviews_staging
where order_id is null;

select *
from order_reviews_staging
where review_score is null;

select *
from order_reviews_staging
where review_comment_title is null;

select *
from order_reviews_staging
where review_comment_message is null;

select *
from order_reviews_staging
where review_answer_timestamp is null;


-- 2.Check duplicates
WITH check_dup as
(
    select 
        *,
        row_number() 
        over(PARTITION BY 
        review_id,
        order_id,
        review_score,
        review_comment_title,
        review_comment_message,
        review_answer_timestamp
        ) as dup
    from order_reviews_staging
)

SELECT *
from check_dup
where dup >1;