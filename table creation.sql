USE draycoe_mart;

-- First step is to create the tables for our database: draycoe_mart

/* First: customers table.  */

CREATE TABLE customers 
				(customer_id INT PRIMARY KEY AUTO_INCREMENT, -- Id for customers with unique numbers.
				  first_name VARCHAR(50) NOT NULL,
                  last_name VARCHAR(50) NOT NULL,
                  city VARCHAR(50) NOT NULL,
                  join_date DATE NOT NULL
                );                
SELECT *
FROM customers; -- To confirm that our table is ready before inserting into it.


-- Second Step is to insert values into the customers table 

INSERT INTO customers
VALUES (1, 'Ada', 'Okafor', 'Lagos', '2023-02-10'),
		(2, 'John', 'Bello', 'Abuja', '2023-03-05'),
        (3, 'Chika', 'Nwosu', 'Port Harcourt', '2023-04-20'),
        (4, 'Emeka', 'Udo', 'Enuhu', '2023-06-15'),
        (5, 'Mary', 'Adebayo', 'Ibadan', '2023-08-02');

SELECT *
FROM customers;

/* Second: products table.  */

CREATE TABLE products 
					(product_id INT PRIMARY KEY AUTO_INCREMENT,
					 product_name VARCHAR(20) NOT NULL,
                     category VARCHAR(20) NOT NULL,
                     price INT(12) NOT NULL
                    );

SELECT *
FROM products;


INSERT INTO products
VALUES (101, 'Laptop', 'Electronics', 480000),
	   (102, 'Phone', 'Electronics', 250000),
       (103, 'Headphone', 'Accessories', 45000),
       (104, 'Desk Chair', 'Furniture', 90000),
       (105, 'Mouse', 'Accessories', 15000);
       
SELECT *
FROM products;

/* Third: orders table.  */

CREATE TABLE orders
					(order_id INT PRIMARY KEY AUTO_INCREMENT,
					 customer_id INT,  
                     product_id INT,
                     quantity INT,
                     order_date DATE NOT NULL,
                     --  foreign keys into the orders table
                     FOREIGN KEY (customer_id) REFERENCES customers(customer_id), 
                     FOREIGN KEY (product_id) REFERENCES products(product_id)
                     );

SELECT *
FROM orders;

INSERT INTO orders 
VALUES		(1001, 1, 101, 1, '2023-03-01'),
			(1002, 1, 105, 2, '2023-04-15'),
			(1003, 2, 103, 1, '2023-03-20'),
			(1004, 3, 102, 1, '2023-05-02'),
			(1005, 3, 105, 3, '2023-07-18'),
			(1006, 4, 104, 1, '2023-08-22'),
			(1007, 4, 101, 1, '2023-09-30'),
			(1008, 5, 102, 1, '2023-09-10'),
			(1009, 5, 105, 2, '2023-10-01');
            
SELECT *
FROM orders;

/* Third: payments table.  */

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    amount INT NOT NULL,
    payment_method VARCHAR(30),
    payment_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- inserting foreign keys into the payments table
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO payments
VALUES
			(11, 1001, 480000, 'Bank Transfer', '2023-03-02 09:45:00'),
			(21, 1002, 30000, 'Card', '2023-04-16 13:22:00'),
			(31, 1003, 45000, 'Cash', '2023-03-21 18:05:00'),
			(41, 1004, 250000, 'Bank Transfer', '2023-05-03 10:10:00'),
			(51, 1005, 45000, 'Card', '2023-07-19 20:35:00'),
			(61, 1006, 90000, 'Cash', '2023-08-23 11:00:00'),
			(71, 1007, 480000, 'Bank Transfer', '2023-10-01 19:40:00'),
			(81, 1008, 250000, 'Card', '2023-09-11 16:55:00'),
			(91, 1009, 30000, 'Cash', '2023-10-02 08:20:00');


SELECT *
FROM payments;
