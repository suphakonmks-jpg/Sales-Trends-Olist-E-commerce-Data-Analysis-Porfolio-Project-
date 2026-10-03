
select 
    oi.order_id,
    oi.product_id,
    oi.price,
    o.order_purchase_timestamp,
    c.customer_unique_id,
    pt.product_category_name_english,
    s.seller_city
from 
    order_items_staging oi
left join 
    orders_staging o
ON
    oi.order_id = o.order_id
LEFT JOIN
    customers_staging c 
ON
    o.customer_id = c.customer_id
LEFT JOIN
    products_staging p
ON
    oi.product_id = p.product_id
left JOIN
    sellers_staging s
ON  
    oi.seller_id = s.seller_id
LEFT JOIN
    product_category_name_translations_staging pt
ON
    p.product_category_name = pt.product_category_name
where 
    EXTRACT(year from o.order_purchase_timestamp) in ('2017','2018') and
    date_trunc('month',o.order_purchase_timestamp) != '2018-09-01 00:00:00'
;