SCTION 2 - INTERMEDIATE 

This file continues the insights generated from the draycoe_mart database analysis, building on the results documented in the easy_level_question_insights.
The questions in this section focus on more complex SQL concepts such as GROUP BY, HAVING, SUBQUERY and aggregate combinations that require deeper analytical thinking.


Q9 - Find the total sales per customer                                                                                                                                                      
            Explanation - To solve this, we have to understand the question first. It says "per customer" and this 
            means for each customer we are to determine how much sales he/she has made. To solve this, I had to
            Group the customers first and perform a SUM of the amount for the customer.
                                          
                                 CODE -    SELECT 
                                                	o.customer_id,    
                                                    SUM(p.amount) AS sales_per_customer
                                          FROM orders AS o
                                          LEFT JOIN payments AS p
                                          ON o.order_id = p.order_id
                                          GROUP BY o.customer_id;
   Further explanation - The purpose of the JOIN is so I can get the amount column which is not present in the orders table.     
   Insights - We realised that customer with ID has a total sales of 510,000.Look at the image below to see the rest.                                                                  
   RESULT - 
  <img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/dd4d1cce-a5a9-44a2-8ce8-4420eaba8cee" />

  Q10 - Show all the total quantity of each product sold                                                                                                                                 
       EXPLANATION - The first thing I did was to JOIN the orders and product table together using LEFT JOIN, the purpose of 
        doing this was to get the column of the quantity and products name from the orders and products table respectively.
        Once that was achieved, I had to now get the SUM of the quantity but remember that the quantity vareies for different products,
        and as a result, I grouped them by product name using GROUP BY. This is shown in the code below;

                                 CODE-    SELECT 
                                                    p.product_name,
                                                   SUM(o.quantity) AS quantity_per_product_sold
                                          FROM orders AS o
                                          LEFT JOIN products AS p
                                          ON o.product_id = p.product_id
                                          GROUP BY p.product_name
                                          ORDER BY quantity_per_product_sold DESC ;
  Insight - After running this code, I realised there were a total of 5 products as shown in the image below and MOUSE has the highest 
            quantity sold amongst them.                                                                                                                                                 
  RESULT - 
  <img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/f4b4fb6c-db08-44f2-b0e7-13c31144259f" />

  Q11 - Find the average payment amount per payment method                                                                                                                              
        Explanation -  This is similar to solving the question 10, only that I don't have to join tables in this case.
        That been said, to get the average of amount for each payment method, I have to first off group the payment methods,
        and this is done using GROUP BY after which i add the AVG(amount). The avg(amount) helps to get the average of the amounts 
       for each payment method. Below is the code: 
       
                                  CODE -   SELECT 
                                      		        payment_method,
                                                     ROUND(AVG(amount), 1) as avg_amount_per_payment_method
                                           FROM payments
                                           GROUP BY payment_method;
  I also have to state that the ROUND expression in the code was done to reduce the decimal numbers. In this case, I wanted one number after decimal hence the '1' after the 'AVG(amount)'   
  Insight - There were 3 payment methods and cash payment method had the least average amount with a value of 55,000.0, this is shown in the image below.                                 
RESULT -
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/aeee4891-87da-4a57-b47f-d7cbb3885cdd" />

  
Q12 - List all customers who made morethan 2 orders
      Explanation - Using GROUP BY, I grouped the customers column, then I did the SUM of quantity purchased by each customers.
      From the code below, you will reasised that I am using the HAVING to filter instead of WHERE filter, this is because the WHERE function
      does not work with aggregate function.
      
                                 CODE-    SELECT 
                                                  customer_id,
                                                   SUM(quantity) AS total_quantity_per_customer
                                          FROM orders
                                          GROUP BY customer_id
                                          HAVING SUM(quantity) > 2;
INSIGHT - From the result I realised that customers with ID: 1, 3 and 5 had a total order above 2.                                                                                            
RESULT -                                      
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/2bcf0d0d-ac10-4267-9faa-312d48cc847c" />

Q13 Find the produts that generated total sales above 100,000
      Explanation - In other to find the product(s) with sales above 100,000

                             CODE-      SELECT 
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

RESULT - 
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/5965977c-11cd-42b1-b79c-520248a8cbcf" />
