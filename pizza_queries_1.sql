-- Retrieve the total number of order placed.
select count(order_id) as total_orders from orders;



-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id;



-- Identify the highest-priced pizza.alter
SELECT 
    pt.name, p.price
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
WHERE
    price = (SELECT 
            MAX(price)
        FROM
            pizzas);



-- Identify the most common pizza size ordered



SELECT 
    p.size, COUNT(od.order_id) AS count_of_size
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY count_of_size DESC
LIMIT 1;



-- list top 5 most ordered pizza types along with their quantity

select pt.name, sum(od.quantity) as quantity from
order_details od
 JOIN
    pizzas p ON od.pizza_id = p.pizza_id
join pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
group by pt.name
order by quantity desc
limit 5;
