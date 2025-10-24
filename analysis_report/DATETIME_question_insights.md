SECTION 4 - DATETIME FUNCTION TASK

This section covers the final stage of the draycoe_mart SQL project, focusing on Date and Time functions.
Here, I analyzed transaction timelines, order trends, and customer activity patterns using SQL’s built-in datetime functions.
Each question includes a short explanation of the logic applied and the insights derived from the analysis.

--Q22. Find the most recent order date and earliest order date                                                                                    
      Explanation -  In this task, to find out when was our customer first order date and last order date, we can use the MIN and MAX function. The min() to determine the earliest, and max() for recent. 
      
                             CODE-      SELECT 
                                             		MIN(order_date) as earliest_date,
                                                  MAX(order_date) AS recent_date
                                        FROM orders;
Insight - I realised that our first order date was 2023-03-01, while last order date was 2023-10-01                                                       
RESULT - 
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/646cba02-06f5-4fa2-a663-954224f3650e" />


--Q23. Find the last order date per customer                                                                                               
      Explanation -  When last each of our customers ordered is an important insight to discover as it will help us know those customer to reach out to, to know why they haven't been patronising or maybe we can just send them a message. So, to solve this, I did the MAX(order date) and GROUPed BY customer ID.
      
                             CODE-      SELECT 
                                             		MIN(order_date) as earliest_date,
                                                  MAX(order_date) AS recent_date
                                        FROM orders;
Insight - I realised that our customer with ID 2 last purchase date was March 2, 2025. That has been long and we should reach out to know why she hasn't been buying from us or we could send a message through email so she can be aware of our new stocks.                                                        
RESULT - 
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/104f80a6-d3ba-4bc4-a70a-ea511ab85400" />


--Q24. Find all the payment made in the morning (before 12pm) vs afternoon/evening(after 12pm)                                                   
      Explanation - What hour of the day do we make lots of sales is an important question for our business because we will know if more man-power will be required to drive more sales.
      
                             CODE-      SELECT 
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
Insight - I realised that we sold more in the PM (Afternoon/Evening) Hours. Now, we might want to talk to the sales attendant to know how they cope during this hour and know if more people will be needed to support them or if they are able to comfortably handle these period.
RESULT - 
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/bed27b98-97e2-4940-9dfb-6da0479a6700" />


-- Q25 Join customers, orders and payments to show customers name, product name, payment amount and date                                          
  Explanation -  This simply wants us to join 3 tables.
      
                             CODE-      SELECT 
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
Insight -                                                       
RESULT - 
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/4ac81a6f-8e85-487c-b44e-52b06f270158" />


-- Q26 Join products and payments to find the top selling products by total payment amount                                                         
  Explanation -  Knowing the product(s) with high demand can literally bring in more numbers to a business. To solve this, I did the sum of the amount for each products, grouped them and ranked the total sum in desc order as this will allow me to know the top selling product.
      
                             CODE-      SELECT 
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
Insight -  I discovered Laptop was our top ranking selling product with total sales of 960000	                                                      
RESULT - 
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/dff8286a-38bd-4d95-83ae-086dfd3c5d9e" />


-- Q27 calculate days between order date and payment date for each transaction                                                               
  Explanation - To know how long it takes for customers to make payment after placing order is key for businesses. In this task, i did a datedifference between payment time and order date
      
                             CODE-      SELECT 
                                          		o.order_date,
                                                  DATE(payment_datetime) AS payment_date,
                                                 DATEDIFF(DATE(payment_datetime), o.order_date ) AS days_between_order_and_payment
                                        FROM orders AS o
                                        LEFT JOIN payments AS pay
                                        ON o.order_id = pay.order_id;
Insight - Suprisingly, we had one day difference on all orders which I think is fair.                                                                                
RESULT - 
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/f0dd9606-73b3-4e5a-8696-e692424ca783" />


