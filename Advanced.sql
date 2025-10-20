 USE draycoe_mart;

-- Q16 Rank customers based on their total purchase amount

SELECT 
		o.customer_id,
        SUM(pay.amount) AS total_purchase_amount_customer,
        RANK() OVER(ORDER BY SUM(pay.amount) ASC ) AS rank_total_purchase
FROM orders AS o
LEFT JOIN payments AS pay
ON o.order_id = pay.order_id
GROUP BY o.customer_id;


 -- Q17 For each products, rank orders by order amount (descending)
 
 SELECT 
		p.product_id,
        p.product_name,
        o.quantity,
        RANK() OVER(ORDER BY o.quantity DESC ) AS rank_orders_quantity
 FROM orders AS o
 LEFT JOIN products AS p
ON  o.product_id = p.product_id;


 -- Q18 Find the running total of payment ordered by date
 
 SELECT 
		*,
        SUM(amount) OVER(ORDER BY payment_datetime ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
 FROM payments;
 
 
  -- Q19 Find the top 3 customers by total payment amount
  
  SELECT *
  FROM (
  SELECT 
		o.customer_id,
        SUM(pay.amount) AS total_payment_per_customer,
        RANK() OVER(ORDER BY SUM(pay.amount) DESC) AS rank_customers
  FROM payments AS pay
  LEFT JOIN orders AS o
  ON pay.order_id = o.order_id
  GROUP BY o.customer_id) AS T
  WHERE T.rank_customers <=3
  ;
  
  
-- Q20 For each payment method, find the average payment and the difference between each payments and that average 
  
SELECT 
		payment_method,
        amount,
        ROUND(AVG(amount) OVER(PARTITION BY payment_method),1) AS avg_amount_per_payment_method,
        amount - ROUND(AVG(amount) OVER(PARTITION BY payment_method),1) AS difference_amount_and_avg
FROM payments;


-- Q21 Find each customer's first and last payment date using windows function

SELECT 
		o.customer_id,
        pay.payment_datetime,
        MIN(payment_datetime) OVER(PARTITION BY o.customer_id) AS first_payment,
        MAX(payment_datetime) OVER(PARTITION BY o.customer_id) AS last_payment
FROM payments AS pay
LEFT JOIN orders AS o
ON pay.order_id = o.order_id;
