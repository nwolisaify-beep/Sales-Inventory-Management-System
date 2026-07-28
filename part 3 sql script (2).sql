# All customers and their orders
select customers.customer_id, customers.first_name, customers.last_name, 
orders.order_id, orders.order_date from customers left join orders on
customers.customer_id=orders.customer_id;

# All products with their suppliers
select products.product_id, products.product_name, products.category, products.supplier_id,
suppliers .supplier_name, suppliers.contact_email from products
left join suppliers on products.supplier_id=suppliers.supplier_id;

# Total number of orders made by each customers
select customers.customer_id,customers.first_name,customers.last_name,
count(orders.order_id) as total_orders
from customers 
left join orders
on customers.customer_id=orders.customer_id
group by customers.customer_id,customers.first_name,customers.last_name;

#Total sales per day
select orders.order_date,sum(payments.amount) as total_sales
from payments 
left join orders
on orders.order_id=payments.order_id
group by order_date;

# Total revenue generated
select sum(amount) as total_revenue
from payments;

# Top 5 best selling product
select products.product_name,sum(order_details.quantity) as total_sold
from order_details left join products on
products.product_ID=order_details.product_ID
group by products.product_name
order by total_sold desc
limit 5;

# Customers who spent more than 150000
select customers.customer_id, customers.first_name, customers.last_name,sum(payments.amount)
as total_spent from customers join orders on 
customers.customer_id=orders.customer_id
 join payments on orders.order_id=payments.order_id
 group by  customers.customer_id, customers.first_name, customers.last_name
having sum(payments.amount)>150000;

# average_order_value
select avg(amount) as average_order_value
from payments;

# product that have never been sold
select products.product_id, products.product_name
from products left join order_details 
on products.product_id=order_details.product_ID
where order_details.product_id is null;

# Customers who have never placed an order
select customers.customer_id, customers.first_name, customers.last_name,
orders.order_id from customers left join orders
on customers.customer_id=orders.customer_id
where orders.order_id is null;

#Orders that contain more than 3 products
select order_id,count(product_id) as number_of_products
from order_details
group by order_id
having count(product_id)>3;