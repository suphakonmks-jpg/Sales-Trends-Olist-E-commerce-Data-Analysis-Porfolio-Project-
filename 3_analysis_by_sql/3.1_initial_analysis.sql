-- revenue by trends
SELECT 
    date_trunc('month',o.order_purchase_timestamp) as month_start_date,
    sum(oi.price)
from order_items oi
left JOIN orders o
on o.order_id =oi.order_id
group by month_start_date
order by 1;


-- orders count by trends
select count(distinct c.customer_unique_id)
from order_items oi
LEFT JOIN orders o
on oi.order_id = o.order_id
left join customers c
on o.customer_id = c.customer_id;


-- orders count by seller city
select seller_city,count(seller_city),
    round(count(seller_city)*100,2)/(select count(*) from order_items)
from order_items oi
LEFT JOIN sellers s
on oi.seller_id = s.seller_id
group by seller_city
order by 2 desc;


-- revenue by seller city
select seller_city,sum(oi.price),
    round(sum(oi.price)*100,2)/(select sum(price) from order_items)
from order_items oi
LEFT JOIN sellers s
on oi.seller_id = s.seller_id
group by seller_city
order by 2 desc;



-- orders count by product category
SELECT 
    product_category_name_english,
    count(product_category_name_english)
from order_items oi
LEFT JOIN products p
on oi.product_id = p.product_id
LEFT JOIN product_category_name_translations pt
on p.product_category_name = pt.product_category_name
group by product_category_name_english
order by 2 desc;




-- chehck for missing product category translations
select *
from order_items oi
left join products p
on oi.product_id = p.product_id
LEFT JOIN product_category_name_translations pt
on p.product_category_name = pt.product_category_name
where pt.product_category_name is null
limit 10;



