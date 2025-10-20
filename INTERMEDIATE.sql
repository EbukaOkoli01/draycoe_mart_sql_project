USE draycoe_mart;

/* Q9. find the total sales per customer */

SELECT 
		o.customer_id, 
        SUM(p.amount) AS sales_per_customer
FROM orders AS o
LEFT JOIN payments AS p
ON o.order_id = p.order_id
GROUP BY o.customer_id;


/* Q10 Show all the total quantity of each product sold */

SELECT 
        p.product_name,
        SUM(o.quantity) AS quantity_per_product
FROM orders AS o
LEFT JOIN products AS p
ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY quantity_per_product DESC ;


/* Q11 Find the average payment amount per payment method */

SELECT 
		payment_method,
       ROUND(AVG(amount), 1) as avg_amount_per_payment_method
FROM payments
GROUP BY payment_method;


/* Q12 list all customers who made morethan 2 orders */ 

SELECT *
FROM
	(
	SELECT 
			c.customer_id,
			sum(o.quantity) AS total_quantity_per_customer
	FROM orders AS o
	LEFT JOIN customers as c
	ON o.customer_id = c.customer_id
	GROUP BY c.customer_id) AS co
WHERE total_quantity_per_customer > 2
;


/* Q13 Find the produts that generated total sales above 100,000 */ 


SELECT 
        p.product_name,
        SUM(pay.amount) AS total_per_products
FROM orders AS o
LEFT JOIN products AS p
ON o.product_id = p.product_id
LEFT JOIN payments AS pay
ON o.order_id = pay.order_id
GROUP BY p.product_name
HAVING SUM(pay.amount) > 100000
ORDER BY total_per_products DESC ; 


/* Q14 Find the number of orders placed per month */

SELECT 
        EXTRACT(MONTH FROM order_date) AS months,
        SUM(quantity) AS orders_per_month
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date) ;

-- method 2
SELECT 
        DATE_FORMAT(order_date , '%b') AS months,
        SUM(quantity) orders_per_month
FROM orders
GROUP BY DATE_FORMAT(order_date , '%b')
ORDER BY orders_per_month DESC ; 


/* Q15 find the customer who spent morethan 200,000 in total */

SELECT 
		o.customer_id,
        SUM(pay.amount) AS total_amount_spent_per_customer
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id = c.customer_id
LEFT JOIN payments AS pay
ON o.order_id = pay.order_id
GROUP BY o.customer_id
HAVING SUM(pay.amount) > 200000; 




