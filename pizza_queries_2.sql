-- join required tables to find total quantity of each pizza category ordered.
SELECT 
    pt.category, COUNT(od.quantity) AS total_quantity
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity DESC;




-- determine the distribution of the orders by hour of the day.
select hour(order_time) as hour, count(order_id) from orders
group by hour(order_time);




-- join relevent tables to find the category-wise distribution of pizza
select category, count(name) as sold_pizza from pizza_types
group by category; 



-- Group the orders by date and calculate avg number of pizza ordered per day.
SELECT 
    round(AVG(total_ordered_pizza), 0)
FROM
    (SELECT 
        o.order_date,
            ROUND(SUM(od.quantity), 0) AS total_ordered_pizza
    FROM
        orders o
    JOIN order_details od ON od.order_id = o.order_id
    GROUP BY o.order_date) AS data;

#alter table orders 
#rename column oerder_date to order_date;



-- Determine the top 3 most ordered pizza types based on revenue
select pt.name, sum(od.quantity*p.price) as revenue from
pizza_types pt join pizzas p 
on pt.pizza_type_id = p.pizza_type_id
join order_details od 
on od.pizza_id = p.pizza_id
group by pt.name
order by revenue desc
limit 3;