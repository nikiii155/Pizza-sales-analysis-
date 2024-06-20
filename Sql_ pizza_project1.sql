SELECT * FROM pizzahut.pizzas;

CREATE TABLE orders (
    order_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    PRIMARY KEY (order_id)
);

CREATE TABLE order_detail (
    order_detail_id INT NOT NULL,
    order_id INT NOT NULL,
    pizza_id TEXT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_detail_id)
);

-- Retrieve   the total number of product sales.
select count(order_id) as total_orders from  orders;

-- Calculate the total number of revenue generated from pizza.

SELECT 
    ROUND(SUM(order_detail.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_detail
        JOIN
    pizzas ON pizzas.pizza_id = order_detail.pizza_id;

-- Identify the highest price pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
    COUNT(order_detail.order_detail_id) AS order_product
FROM
    pizzas
        JOIN
    order_detail ON pizzas.pizza_id = order_detail.pizza_id
GROUP BY pizzas.size
ORDER BY order_product DESC;

-- List the top 5 most ordered pizza along with their quantities

SELECT 
    pizza_types.name,
    SUM(order_detail.quantity) AS total_quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_detail ON order_detail.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC limit 5 ;

-- Joint the necessary table to find the total quantity of   each   pizza ordered.


SELECT 
    pizza_types.category, SUM(order_detail.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_detail ON order_detail.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;


-- Determine the distribution of order hour of the day.

SELECT 
    HOUR(order_time) as_hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);

-- Join   Relevant   table to find the category wise distribution of pizzas.
select category , count(name) from pizza_types
group by category;

-- Group the ordered by date and calculate the average number of pizzas order per day.
 
 SELECT 
    ROUND(AVG(quantity), 0) as avg_pizza_order_per_day
FROM 
    (SELECT 
        orders.order_date, SUM(order_detail.quantity) AS quantity
    FROM
        orders
    JOIN order_detail ON orders.order_id = order_detail.order_id
    GROUP BY orders.order_date) AS order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.





