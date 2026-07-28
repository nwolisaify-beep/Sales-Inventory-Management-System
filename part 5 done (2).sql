-- Generate a report showing customer name, order date, product name, quantity, and amount paid

SELECT customers.first_name,
       customers.last_name,
       orders.order_date,
       products.product_name,
       order_details.quantity,
       payments.amount
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
JOIN payments ON orders.order_id = payments.order_id;


-- Generate a summary report of total customers, total products, total orders, and total revenue.
SELECT 
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT COUNT(*) FROM products) AS total_products,
    (SELECT COUNT(*) FROM orders) AS total_orders,
    (SELECT SUM(amount) FROM payments) AS total_revenue;
    
-- Identify loyal customers (customers with highest number of orders).
SELECT customers.customer_id,
       customers.first_name,
       customers.last_name,
       COUNT(orders.order_id) AS total_orders
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id,
         customers.first_name,
         customers.last_name
ORDER BY total_orders DESC
LIMIT 5;

-- Identify slow-moving products (products with very low sales)
SELECT products.product_id,
       products.product_name,
       products.category,
       COALESCE(SUM(order_details.quantity * products.price), 0) AS total_sales
FROM products
LEFT JOIN order_details
ON products.product_id = order_details.product_id
GROUP BY products.product_id,
         products.product_name,
         products.category
ORDER BY total_sales ASC
LIMIT 5;

# Products that should be restocked based on sales
SELECT products.product_name,
       SUM(order_details.quantity) AS total_sold
FROM order_details
JOIN products
ON order_details.product_id = products.product_id
GROUP BY products.product_name
ORDER BY total_sold DESC
LIMIT 5;

-- Recommend the best performing supplier
SELECT suppliers.supplier_name,
       SUM(order_details.quantity) AS total_sales
FROM suppliers
JOIN products ON suppliers.supplier_id = products.supplier_id
JOIN order_details ON products.product_id = order_details.product_id
GROUP BY suppliers.supplier_name
ORDER BY total_sales DESC
LIMIT 1;