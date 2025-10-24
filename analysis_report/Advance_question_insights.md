SCTION 3 - ADVANCED

This section continues the documentation of insights derived from the draycoe_mart database analysis.
It focuses on advanced SQL concepts such as subqueries, window functions, and complex joins.
Each question highlights the thought process behind the query, the logic used to solve it, and the insights uncovered from the analysis.

-- Q16 Rank customers based on their total purchase amount
      Explanation - In business, we will like to know our MVPs and the rank function is the best function which can help us with that. In this question, to rank customers based on total purcharse amount, we have to first of JOIN orders and Payments table, then we do sum of amount for each customer using GROUP BY and finaly we will rank customers by the total amount. 

                             CODE-      SELECT 
                                               o.customer_id,
                                              SUM(pay.amount) AS total_purchase_amount_customer,
                                              RANK() OVER(ORDER BY SUM(pay.amount) ASC ) AS rank_total_purchase
                                        FROM orders AS o
                                        LEFT JOIN payments AS pay
                                        ON o.order_id = pay.order_id
                                        GROUP BY o.customer_id;
Insight - From the result, customer with ID 2 had the least total purchase amount with value of 45,000.     
RESULT - 
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/e4484740-560d-45ad-a075-87f4022a014b" />


-- Q17 For each products, rank orders by order amount (descending)
      Explanation -  In this case, we wanted to know how which product(s) customers buy more. 
      
                             CODE-      SELECT 
                                               p.product_name,
                                               SUM(o.quantity) AS total_orders,
                                               RANK() OVER(ORDER BY SUM(o.quantity) DESC ) AS rank_orders_quantity
                                       FROM orders AS o
                                       LEFT JOIN products AS p
                                       ON  o.product_id = p.product_id
                                       GROUP BY product_name ;
Insight - We had a total of 5 products, Mouse is our most purchased while laptop and phone has a tie of 2 each as well as headphone and desk chair also tied .                                                        
RESULT - 
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/0e2383a4-075e-43c8-a782-2df8c0bc2b32" />

-- Q19 Find the top 3 customers by total payment amount
      Explanation -  To know our top 3 customers based on payment amount, we will need the payment and orders table. First off, I did a subquery to get the customers,also rank them and once I had my result, I embeded it into another FROM statement. Ordinarily, I would have used the WHERE filter instead of taking subquery route but I can't filter with the window function statement so the best thing to do was use a subquery because this would allow me to be able to filter using the WHERE statement. 
      
                             CODE-      SELECT 
                                               *
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
Insight - Our top three customers based on toatal payment made were customers with ID 4, 1, 3 .                                                    
RESULT - 
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/65f10e1b-99b1-4d18-b70b-604d0673c9d6" />


-- Q20 For each payment method, find the average payment and the difference between each payments and that average
      Explanation -  It is one thing for us to have 3 modes of payments in our business which is fine but also knowing which our customers mostly uses is another thing. In this case, we will be obtaining average payment on each payment method. To do this, we get the average on each payment method by PARTITIONING BY payment method. GROUP BY won't work in this case because I needed all level of details plus there is morethan one column present.  
      
                             CODE-      SELECT 
                                               payment_method,
                                               amount,
                                              ROUND(AVG(amount) OVER(PARTITION BY payment_method),1) AS avg_amount_per_payment_method,
                                              amount - ROUND(AVG(amount) OVER(PARTITION BY payment_method),1) AS difference_amount_and_avg
                                       FROM payments;
Insight - While bank transfer had the highest average amount, cash mode of payment was least. we might just conclude that most people don't go about with cash.                                                       
RESULT - 
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/b4b43827-bc4d-424b-bf24-ad976d7f99f5" />

-- Q21 Find each customer's first and last payment date using windows function
      Explanation -  We want to know our loyal customers and then only way to know this is to when was their last purchase. This can easily be achied using FIRST_VALUE and LAST_VALUE function. 
      
                             CODE-      SELECT 
                                    		       customer_id,
                                               first_payment_date,
                                               last_payment_date
                                        FROM
                                        		(SELECT 
                                        				o.customer_id,
                                        				pay.payment_datetime,
                                        				FIRST_VALUE(pay.payment_datetime) OVER(PARTITION BY o.customer_id ORDER BY pay.payment_datetime) AS first_payment_date,
                                        				LAST_VALUE(pay.payment_datetime) OVER(PARTITION BY o.customer_id ORDER BY pay.payment_datetime
                                        														ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS last_payment_date,
                                        				RANK() OVER(PARTITION BY o.customer_id ORDER BY pay.payment_datetime) AS rank_
                                        		FROM payments AS pay
                                        		LEFT JOIN orders AS o
                                        		ON pay.order_id = o.order_id ) AS t
                                    WHERE t.rank_ = 1;
-- Method 2

                          CODE -     SELECT 
                                  		      customer_id,
                                            first_payment,
                                            last_payment
                                     FROM
                                          (SELECT 
                                          		o.customer_id,
                                                  pay.payment_datetime,
                                                  MIN(payment_datetime) OVER(PARTITION BY o.customer_id) AS first_payment,
                                                  MAX(payment_datetime) OVER(PARTITION BY o.customer_id) AS last_payment,
                                                  RANK() OVER(PARTITION BY o.customer_id ORDER BY pay.payment_datetime) AS rank_payment_date
                                          FROM payments AS pay
                                          LEFT JOIN orders AS o
                                          ON pay.order_id = o.order_id) AS t
                                  WHERE t.rank_payment_date = 1;
Insight - The result below shows the customers first and last payment date                                     
RESULT - 
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/8c07e953-444d-4c81-8905-e80d952e4363" />

