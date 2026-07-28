### Ranking customer based on total amount spent ###

select customers.customer_id,customers.first_name,customers.last_name,
 sum(payments.Amount) as total_spent, 
 rank() over (order by sum(payments.Amount)desc) as spending_rank
 from customers
 join orders on customers.Customer_id=orders.Customer_id
 join payments  on orders.Order_id=payments.Order_id
 group by customers.Customer_id,customers.first_name,customers.last_name;
 
 ### Product category with highest revenue ##
 
 select products.category,
 sum(products.price * order_details.quantity) as highest_revenue
 from order_details 
 join products on products.product_id=order_details.product_id
 group by products.category
 order by  highest_revenue desc
 limit 1;
 
 ### supplier whose product sell the most ###
 
 select suppliers.supplier_id,suppliers.supplier_name,
 sum(order_details.quantity) as best_seller
 from suppliers
 join products on products.supplier_id=suppliers.supplier_id
 join order_details on order_details.product_id=products.product_id
 group by suppliers.supplier_id,suppliers.supplier_name
 order by best_seller desc
 limit 1;
 
### customer who placed more than 5 orders ## 
 
 SELECT customers.customer_id,
       customers.first_name,
       customers.last_name,
       COUNT(orders.order_id) AS total_orders
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id,
         customers.first_name,
         customers.last_name
HAVING COUNT(orders.order_id) > 5;

### Orders with highest total quantity of items ###

select orders.order_id,orders.order_date,
 sum(order_details.quantity) as total_item
 from orders
 join order_details on orders.order_id=order_details.order_id
 group by orders.order_id,orders.order_date
 order by total_item desc
 limit 1;
 
 ### show monthly sales performances ###
 
 SELECT DATE_FORMAT(orders.Order_date, '%Y-%m') AS month,
SUM(payments.Amount) AS monthly_revenue,
COUNT(DISTINCT orders.Order_id) AS total_orders
FROM orders 
JOIN payments  ON orders.Order_id = payments.Order_id
GROUP BY DATE_FORMAT(orders.Order_date, '%Y-%m')
ORDER BY month;

### Products with price above the average product price ####
 
 select products.product_id,products.product_Name,products.price
 from products
 where price > (select avg(price) from products)
 order by Price desc;
 
 ### Find customer whose total spending is above the overall average spending ###

SELECT customers.customer_id, customers.first_name,customers.last_name,
       SUM(payments.amount) AS total_spent
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
JOIN payments ON orders.order_id = payments.order_id
GROUP BY customers.customer_id, customers.first_name,customers.last_name
HAVING SUM(payments.amount) > (
    SELECT AVG(total) FROM (
        SELECT SUM(payments.amount) AS total
        FROM orders
        JOIN payments ON orders.order_id = payments.order_id
        GROUP BY orders.customer_id
    ) AS avg_table
);

