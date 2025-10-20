USE draycoe_mart;


--  Q1 - Find the total number of customers in the database

SELECT 
		COUNT(*) AS no_of_customers
FROM customers; 


-- Q2 - Find the total number of orders 

SELECT 
		COUNT(*) AS no_of_orders
FROM orders; 


-- Q3 - Find the total sales amount from the payment table */

SELECT 
		SUM(amount) AS total_sales
FROM payments; 


-- Q4 - Find the average order amount from the payment table 

SELECT 
		AVG(amount) AS avg_order_amount
FROM payments;


-- Q5 - Find the min and maximun payment amount made 

SELECT 
		MIN(amount) AS min_amount,
        MAX(amount) AS max_amount
FROM payments;

-- Q6 - Find the total quantity of product sold 

SELECT 
		o.product_id,
        o.quantity,
        p.payment_id,
        SUM(o.quantity) OVER() AS total_quantity_sold
FROM orders AS o
LEFT JOIN payments AS p
ON o.order_id = p.order_id;


-- Q7 - Find the number of distinct payment methods used 

SELECT 
        COUNT(DISTINCT (payment_method)) AS no_of_payment_method
FROM payments;


-- Q8 - Find the total amount paid per payment method and rank the amount

SELECT 
		payment_method,
        SUM(amount) AS amount_per_payment_method,
        RANK() OVER(ORDER BY payment_method) AS rank_amount_per_payment_method
FROM payments
GROUP BY payment_method;