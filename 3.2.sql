select  (case when row_number() over (partition by t.status order by extract(year from t.order_date)) =1 then t.status else ' ' end)as   status  , extract(year from t.order_date) as Year_, 
count(t.order_id) as quantity_order, 
lag(count(t.order_id),1, null) over(partition by status order by extract(year from t.order_date)) as prev_order,
count(t.order_id) -lag(count(t.order_id),1, null) over(partition by status order by extract(year from t.order_date)) as difference 
from (select  o.ORDER_DATE, i.order_id, o.status from order_items i inner join orders o on o.order_id= i.order_id) t 
group by t.status, extract(year from t.order_date);
