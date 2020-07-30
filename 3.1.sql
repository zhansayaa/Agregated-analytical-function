SELECT  extract (year from t.order_date) as year, sum(saless)as sales, p.product_id,  pc.category_name  
from (select i.unit_price* i.quantity as saless, o.ORDER_DATE, i.product_id from order_items i inner join orders o on o.order_id= i.order_id) t  
 inner join products p on  p.product_id=t.product_id join product_categories pc on pc.category_id=p.category_id  
 group by rollup(extract( year from t.order_date),pc.category_name, p.product_id)

