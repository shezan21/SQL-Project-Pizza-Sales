-- Basic Questions --

-- Q.1 Retrieve the total number of orders placed. --

select count(order_id) as total_orders from orders;


-- Q.2 Calculate the total revenue generated from pizza sales. --

SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    orders_details JOIN pizzas
        ON orders_details.pizza_id = pizzas.pizza_id;
       
       

-- Q.3 Identify the highest-priced pizza. --

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types JOIN pizzas
        ON pizza_types.pizza_type_id = pizzas.pizza_type_id
			ORDER BY pizzas.price DESC
		LIMIT 1;
        

-- Q.4 Identify the most common pizza size ordered. --

SELECT 
    pizzas.size, COUNT(orders_details.order_details_id) as order_count
FROM
    pizzas JOIN orders_details
    ON pizzas.pizza_id = orders_details.pizza_id
	GROUP BY pizzas.size 
    ORDER BY order_count DESC;
    

-- Q.5 List the top 5 most ordered pizza types along with their quantities.--

SELECT 
    pizza_types.name, SUM(orders_details.quantity) AS quantity
FROM
    pizza_types JOIN pizzas
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;


-- Intermediate Questions --

-- Q.6 Join the necessary tables to find the total quantity of each pizza category ordered. --

SELECT 
    pizza_types.category,
    SUM(orders_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;



-- Q.7 Determine the distribution of orders by hour of the day. --

SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);



-- Q.8 Join relevant tables to find the category-wise distribution of pizzas. --

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;




-- Q.9 Group the orders by date and calculate the average number of pizzas ordered per day. --

SELECT 
    ROUND(AVG(quantity), 0) AS avg_pizzas_ordered_per_day
FROM
    (SELECT 
        orders.order_date, SUM(orders_details.quantity) AS quantity
    FROM
        orders
    JOIN orders_details ON orders.order_id = orders_details.order_id
    GROUP BY orders.order_date) AS order_quantity;
    

-- Q.10 Determine the top 3 most ordered pizza types based on revenue. --

SELECT 
    pizza_types.name,
    SUM(orders_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;



-- Advanced --

-- Q.11 Calculate the percentage contribution of each pizza type to total revenue. --

SELECT 
    pizza_types.category,
    ROUND(SUM(orders_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(orders_details.quantity * pizzas.price),
                                2) AS total_sales
                FROM
                    orders_details
                        JOIN
                    pizzas ON orders_details.pizza_id = pizzas.pizza_id) * 100,
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;



-- Q 12. Analyze the cumulative revenue generated over time. --

select order_date,
sum(revenue) over(order by order_date) as cum_revenue
from
(select orders.order_date,
sum(orders_details.quantity * pizzas.price) as revenue
from orders_details join pizzas
on orders_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = orders_details.order_id
group  by orders.order_date) as sales;



-- Q13. Determine the top 3 most ordered pizza types based on revenue for each pizza category. --

select name, revenue from
(select category, name, revenue,
rank() over(partition by category order by revenue desc) as rn
from
(select pizza_types.category, pizza_types.name, 
sum((orders_details.quantity) * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name) as a) b
where rn <= 3;