-- revenue by trends
select 
    date_trunc('month',o.order_purchase_timestamp) as month_start_date,
    sum(oi.price)
from order_items oi
LEFT JOIN orders o
on oi.order_id = o.order_id
where 
    EXTRACT(year from o.order_purchase_timestamp) in ('2017','2018') and
    date_trunc('month',o.order_purchase_timestamp) != '2018-09-01 00:00:00'
group by month_start_date
order by month_start_date
;


-- orders count by trends
select 
    date_trunc('month',o.order_purchase_timestamp) as month_start_date,
    count(DISTINCT oi.order_id)
from order_items oi
LEFT JOIN orders o
on oi.order_id = o.order_id
group by month_start_date
having date_trunc('month',o.order_purchase_timestamp) != '2018-09-01 00:00:00'
order by month_start_date
;



-- AOV by trends
select 
    date_trunc('month',o.order_purchase_timestamp) as month_start_date,
    round(sum(oi.price)/count(DISTINCT oi.order_id),2) as AOV
from order_items oi
LEFT JOIN orders o
on oi.order_id = o.order_id
group by month_start_date
having date_trunc('month',o.order_purchase_timestamp) != '2018-09-01 00:00:00'
order by month_start_date
;



-- top 10 category by sales
select 
    pt.product_category_name_english,
    sum(oi.price),
     concat(round(sum(oi.price)*100/(SELECT sum(price) from order_items),2),'%') as PCT
from order_items oi
LEFT JOIN products p
on oi.product_id = p.product_id
left join product_category_name_translations pt
on p.product_category_name = pt.product_category_name
GROUP BY pt.product_category_name_english
ORDER BY 2 DESC
limit 10
; 


-- top 10 category by sales
select 
    pt.product_category_name_english,
    count(p.product_category_name),
    concat(count(p.product_category_name)*100/(SELECT count(*)from order_items),'%') as PCT
from order_items oi
LEFT JOIN products p
on oi.product_id = p.product_id
left join product_category_name_translations pt
on p.product_category_name = pt.product_category_name
GROUP BY pt.product_category_name_english
ORDER BY 2 DESC
limit 10
; 


-- Top 5 categories sales by top 3 branches by trends
select 
    date_trunc('month',o.order_purchase_timestamp) as month_start_date,
    s.seller_city,
    count(s.seller_city),
    sum(case when pt.product_category_name_english = 'health_beauty' then oi.price end) as health_beauty,
    sum(case when pt.product_category_name_english = 'watches_gifts' then oi.price end) as watches_gifts,
    sum(case when pt.product_category_name_english = 'bed_bath_table' then oi.price end) as bed_bath_table,
    sum(case when pt.product_category_name_english = 'sports_leisure' then oi.price end) as sports_leisure,
    sum(case when pt.product_category_name_english = 'computers_accessories' then oi.price end) as computers_accessories
from order_items oi
LEFT JOIN orders o
on oi.order_id = o.order_id
LEFT JOIN products p
on oi.product_id = p.product_id
left join product_category_name_translations pt
on p.product_category_name = pt.product_category_name
left join sellers s
on oi.seller_id = s.seller_id
where 
    s.seller_city in ('sao paulo','ibitinga','curitiba') and
    EXTRACT(year from o.order_purchase_timestamp) in ('2017','2018') and
    date_trunc('month',o.order_purchase_timestamp) != '2018-09-01 00:00:00'
GROUP BY month_start_date,s.seller_city
ORDER BY 2 ,1




-- Top 5 categories sales by top 3 branches order by top branches by trends
with aaa as
(
select 
    date_trunc('month',o.order_purchase_timestamp) as month_start_date,
    s.seller_city,
    count(s.seller_city) over(partition by s.seller_city) as top_order_count,
    product_category_name_english,
    price
from order_items oi
LEFT JOIN orders o
on oi.order_id = o.order_id
LEFT JOIN products p
on oi.product_id = p.product_id
left join product_category_name_translations pt
on p.product_category_name = pt.product_category_name
left join sellers s
on oi.seller_id = s.seller_id
where 
    s.seller_city in ('sao paulo','ibitinga','curitiba') and
    EXTRACT(year from o.order_purchase_timestamp) in ('2017','2018') and
    date_trunc('month',o.order_purchase_timestamp) != '2018-09-01 00:00:00'
ORDER BY 3 desc
)

select 
    month_start_date,
    seller_city,
    max(top_order_count),
    sum(case when product_category_name_english = 'health_beauty' then price end) as health_beauty,
    sum(case when product_category_name_english = 'watches_gifts' then price end) as watches_gifts,
    sum(case when product_category_name_english = 'bed_bath_table' then price end) as bed_bath_table,
    sum(case when product_category_name_english = 'sports_leisure' then price end) as sports_leisure,
    sum(case when product_category_name_english = 'computers_accessories' then price end) as computers_accessories
from aaa
GROUP BY seller_city,month_start_date
order by max(top_order_count) desc,month_start_date
;



