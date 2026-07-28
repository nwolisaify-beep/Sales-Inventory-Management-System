-- revenue by product category
SELECT products.category,
       SUM(order_details.quantity * products.price) AS total_revenue
FROM products
JOIN order_details
ON products.product_id = order_details.product_id
GROUP BY products.category
ORDER BY total_revenue DESC
LIMIT 7;

-- payment method by percentage
SELECT payment_method,
       COUNT(*) AS total_transactions,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM payments), 2) AS percentage_share
FROM payments
GROUP BY payment_method
ORDER BY percentage_share DESC;

-- top 5 customers by spending
SELECT customers.customer_id,
       customers.first_name,
       customers.last_name,
       SUM(payments.amount) AS total_spent
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
JOIN payments
ON orders.order_id = payments.order_id
GROUP BY customers.customer_id,
         customers.first_name,
         customers.last_name
ORDER BY total_spent DESC
LIMIT 5;

-- top 5 selling best products
SELECT products.product_id,
       products.product_name,
       SUM(order_details.quantity) AS total_sold
FROM products
JOIN order_details
ON products.product_id = order_details.product_id
GROUP BY products.product_id,
         products.product_name
ORDER BY total_sold DESC
LIMIT 5;


-- top revenue category
SELECT products.category,
       SUM(order_details.quantity * products.price) AS total_revenue
FROM products
JOIN order_details
ON products.product_id = order_details.product_id
GROUP BY products.category
ORDER BY total_revenue DESC
LIMIT 1;

-- top performing supplier
SELECT suppliers.supplier_id,
       suppliers.supplier_name,
       COUNT(products.product_id) AS total_products
FROM suppliers
JOIN products
ON suppliers.supplier_id = products.supplier_id
GROUP BY suppliers.supplier_id,
         suppliers.supplier_name
ORDER BY total_products DESC
LIMIT 1;

-- slow moving products
SELECT products.product_id,
       products.product_name,
       products.category,
       COALESCE(SUM(order_details.quantity * products.price), 0) AS total_revenue
FROM products
LEFT JOIN order_details
ON products.product_id = order_details.product_id
GROUP BY products.product_id,
         products.product_name,
         products.category
ORDER BY total_revenue ASC
LIMIT 2;