

# loyal customers(customers with highest number od orders)
select customers.customer_id,customers.first_name,customers.last_name,
count(orders.order_id) as total_orders from customers join 
orders on
customers.customer_id=orders.customer_id
group by customers.customer_id,customers.first_name,customers.last_name
order by count(orders.order_id) desc
limit 1;




