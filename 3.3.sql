select sum(t.sales) as order_s,avg(t.sales) over(partition by c.Name) as Average, extract(year from t.order_date) as Year, (case when row_number() over (partition by c.Name 
order by extract(year from t.order_date)) =1 then c.name else ' ' end)as   client  
from (select i.unit_price* i.quantity as sales, o.ORDER_DATE, o.customer_id from order_items i inner join orders o on o.order_id= i.order_id) t  
join customers c on c.customer_id=t.customer_id 
group by rollup(Name, extract(year from order_date), t.sales);
