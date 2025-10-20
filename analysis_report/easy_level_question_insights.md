This document summarizes each SQL question solved in the draycoe_mart Project. 

The report is organized into categories - from Easy to Intermediate, Advanced, and finally the DATETIME tasks. 
It explains the logic applied in solving each question and highlights the key insights derived from the analysis.

SECTION 1 - EASY 

Q1 - Find the total number of customers in the database
    Explanation - To solve this, I used the "COUNT" function together with the wildcard (*). 
    This combination helps counts the total rows from specified customers tables.Looking at the
    code below, you will realise I used 'AS no_of_customer', this is an aliase used to rename 
    the the column from the default 'COUNT(*)'.
                  
                             CODE -          SELECT 
                                                     COUNT(*) AS no_of_customers 
                                             FROM customers; 
  Insights - There were a total of 5 customers in the customers table.

Q2. Find the total number of orders 
     Explanation - This is similar to task 1 only that we will be using the orders table so that 
     we can get the total orders from the table.
     
                         CODE - SELECT 
                                       COUNT(*) AS total_orders
                               FROM orders.
  Insights - There were a total of 9 orders made from the orders table.

Q3 - Find the total sales amount from the payment table
    Explanation - To get the total sales amount from payment table, I used the SUM() function. 
    
                          CODE -   SELECT 
                                          SUM(amount) AS total_sales
                                   FROM payments; 
  Insights -   The total amounts made from sales was 1,700,000 

Q4 - Find the average order amount from the payment table 
    Explanation - The average order amount is gotten using the function AVG(). This does the sum 
    total of the amount first and gets the average. 
    
                          CODE -   SELECT 
                                          AVG(amount) AS avg_order_amount
                                   FROM payments; 
  Insights -   The average amounts of sales was 188888.8889

Q5 - Find the min and maximun payment amount made
    Explanation - Using the MIN() and MAX() function, I was able to get the highest and lowest amount
    that was made from sales. 
    
                          CODE -   SELECT 
                                      		MIN(amount) AS min_amount,
                                          MAX(amount) AS max_amount
                                    FROM payments;
  Insights -   The highest amount made from sales was 480,000 and the lowest was 30,000

Q6 - Find the total quantity of product sold 
    Explanation - To solve this, I had to join the orders and payments tavle first of. This was dome
    so that I will be able to output the columnns, product_id, quantity and payment_id which were from
    the orders,orders and payments table respectively. Once I was able to do this, I did the SUM(quantity)
    and with the help of windows function OVER(), I did the SUM of quantity over the entire table. 
    It is important to note that i can't use the GROUP BY in this case since there were multiple columns
    spcified.
    
                          CODE -   SELECT 
                                      		o.product_id,
                                              o.quantity,
                                              p.payment_id,
                                              SUM(o.quantity) OVER() AS total_quantity_sold
                                  FROM orders AS o
                                  LEFT JOIN payments AS p
                                  ON o.order_id = p.order_id;
  Insights -   The total quantity sold is 13.

  
Q7 - Find the number of distinct payment methods used
    Explanation - To get the distinct payment method used,
                  firstly, I had to do SELECT DISTINCT (payment_method) from the payment.
                  Secondly, Once the result was out, I did COUNT(DISTINCT (payment_method)).
    
                          CODE -   SELECT 
                                      		COUNT(DISTINCT (payment_method)) AS no_of_payment_method
                                   FROM payments;                    
  Insights -   This show that no_of_payment_method = 3 {cash, transfer, card}

Q8 - Find the total amount paid per payment method and rank the amount
    Explanation - This requires that we get the total amount paid from the the 3 different payment
    method after which we rank the amount in an order, whether ascending (ASC) or descending(DESC)

                          CODE -    SELECT 
                            		          payment_method,
                                          SUM(amount) AS amount_per_payment_method,
                                          RANK() OVER(ORDER BY SUM(amount) DESC) AS rank_amount_per_payment_method
                                    FROM payments
                                    GROUP BY payment_method;
  Further explanation - In this question, I used both GROUP BY and WINDOW FUNCTION, this is because I wanted
  a compress level of details. The GRoup by does the grouping of the various payment method and allows the
  sum calculation to be done for the distinct payment method, after which, the windows ranking function
  now ranks the result in desc order.

  Insights - Bank Transfer	with a total of 1,210,000 ranked 1,
                    Card had a total of 325,000 and ranked	2, while
                    Cash	was 165,000	 and ranked 3.
                    
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/9e96f2c0-712f-4391-9589-240f72ca5ab8" />




