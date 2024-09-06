- # **Project Overview:**

This SQL project revolves around a database schema designed to manage and analyze data for a pizza store. The database consists of four primary tables: order_details, pizzas, orders, and pizza_types. Each table plays a crucial role in storing different facets of the business operations, from individual orders to the types of pizzas offered. Below is a detailed description of each table and its columns:

1. **orders:**
   - order_id: A unique identifier for each order places.
   - order_date: The date on which the order was places.
   - order_time: the time at ehich the order was placed.

2. **orders_details:**
   - order_details_id: A unique identifier for each entry in the order details.
   - order_id: References the ID from the orders table, linking the order details to a specific order.
   - pizza_id: References the ID from the pizza table, identifying which pizza was ordered.
   - quantity: THe numbers of pizzas ordered of the specific type.

3. **pizza_type:**
   - pizza_type_id: A unique identifier for each type of pizza.
   - name: The name of the pizza type (e.g., Margherita, Pepperoni).
   - category: Categorizes the pizza (e.g., Vegetarian, Non-Vegetarian).
   - ingredients: Lists the ingredients used in the pizza.

4. **pizzas:**
   - pizza_id: A unique identifier for each type of pizza available.
   - pizza_type_id: Links to the pizza_types table, specifying the type of pizza.
   - size: The size of the pizza (e.g., small, medium, large).
   - price: The cost of the pizza.
  ---

# **Basic Questions:**
1. Retrieve the total number of orders placed.
2. Calculate the total revenue generated from pizza sales.
3. Identify the highest-priced pizza.
4. Identify the most common pizza size ordered.
5. List the top 5 most ordered pizza types along with their quantities.


# **Intermediate Questions:**
1. Join the necessary tables to find the total quantity of each pizza category ordered.
2. Determine the distribution of orders by hour of the day.
3. Join relevant tables to find the category-wise distribution of pizzas.
4. Group the orders by date and calculate the average number of pizzas ordered per day.
5. Determine the top 3 most ordered pizza types based on revenue.

# **Advanced Questions:**
1. Calculate the percentage contribution of each pizza type to total revenue.
2. Analyze the cumulative revenue generated over time.
3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
