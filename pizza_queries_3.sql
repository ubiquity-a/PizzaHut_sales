-- Calculate the percentage contribution of each pizza type to total revenue
SELECT 
    pt.category,
    CONCAT(ROUND((SUM(od.quantity * p.price) / (SELECT 
                            ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
                        FROM
                            order_details od
                                JOIN
                            pizzas p ON p.pizza_id = od.pizza_id)) * 100,
                    2),
            '%') AS rev
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY rev DESC;



-- Analyze the cumulative revenue generated over time
select order_date, sum(total_revenue) over (order by order_date) as cum_revenue from
(
select o.order_date, ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM
order_details od
JOIN
pizzas p ON p.pizza_id = od.pizza_id
join orders o 
on o.order_id = od.order_id
group by o.order_date
)
 as sales;
 
 
 
 -- Determine top 3 most ordered pizza types based on revenue for each pizza category.
 
 select category, name, total_revenue from
 (select category, name, total_revenue, rank()  over (partition by category  order by total_revenue desc) as ranked_revenue from
(
select pt.category, pt.name, ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM
order_details od
JOIN
pizzas p ON p.pizza_id = od.pizza_id
join pizza_types pt
on pt.pizza_type_id = p.pizza_type_id
group by pt.category, pt.name
)
 as ranked) as b
 where ranked_revenue <=3
;

