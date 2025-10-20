USE draycoe_mart;

-- Q22. Find the most recent order date and earliest order date 

SELECT 
		MIN(order_date) as earliest_date,
        MAX(order_date) AS recent_date
FROM orders;


-- Q23. Find the last order date per customer

SELECT 
		customer_id,
		MAX(order_date) AS last_order_date_per_customer
FROM orders
GROUP BY customer_id;


-- Q24. Find all the payment made in the morning (before 12pm) vs afternoon/evening(after 12pm) tough

SELECT 
		payment_id,
        payment_method,
        payment_datetime,
        DATE_FORMAT(payment_datetime, '%r') AS payment_time,
        DATE_FORMAT(payment_datetime, '%p') AS payment_hour,
		CASE 
				WHEN DATE_FORMAT(payment_datetime, '%p') = 'AM'
				THEN 'Morning'
				ELSE 'Afternoon/Evening'
		END AS period_of_transaction
FROM payments
ORDER BY payment_time
;


-- Q25 Join customers, orders and payments to show customers name, product name, payment amount and date 

SELECT 
		CONCAT(c.first_name, ' ', last_name) AS customer_name,
        p.product_name,
        pay.amount,
        DATE(pay.payment_datetime) AS dates
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id = c.customer_id
LEFT JOIN payments AS pay
ON o.order_id = pay.order_id
LEFT JOIN products as p
ON o.product_id = p.product_id;


-- Q26 Join products and payments to find the top selling products by total payment amount

SELECT *
FROM
		(
		SELECT 
				p.product_name,
				SUM(pay.amount) AS total_sales_from_product,
				RANK() OVER(ORDER BY SUM(pay.amount) DESC ) AS top_selling_product
		FROM orders AS o
		LEFT JOIN products as p
		ON o.product_id = p.product_id
		LEFT JOIN payments as pay
		ON o.order_id = pay.order_id
		GROUP BY p.product_name) AS mart
WHERE mart.top_selling_product = 1
;


-- Q28 calculate days between order date and payment date for each transaction

SELECT 
		o.order_date,
        DATE(payment_datetime) AS payment_date,
       DATEDIFF(DATE(payment_datetime), o.order_date ) AS days_between_order_and_payment
FROM orders AS o
LEFT JOIN payments AS pay
ON o.order_id = pay.order_id;