1.
SELECT u.user_id, u.user_name, o.order_id
FROM users u
JOIN `order` o ON u.user_id = o.user_id;

2.
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS number_of_orders
FROM users u
LEFT JOIN `order` o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name;

3.
SELECT o.order_id, COUNT(od.product_id) AS number_of_products
FROM `order` o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id;

4.
SELECT 
    u.user_id,
    u.user_name,
    o.order_id,
    p.product_name
FROM users u
JOIN `order` o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
ORDER BY o.order_id, p.product_name;

5.
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS number_of_orders
FROM users u
JOIN `order` o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name
ORDER BY number_of_orders DESC
LIMIT 7;

6.
SELECT u.user_id, u.user_name, o.order_id, p.product_name
FROM users u
JOIN `order` o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name LIKE '%Samsung%' OR p.product_name LIKE '%Apple%'
LIMIT 7;

7.
SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_amount
FROM users u
JOIN `order` o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id, u.user_name, o.order_id;

8.
SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_amount
FROM users u
JOIN `order` o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id, u.user_name, o.order_id
HAVING total_amount = (
    SELECT MAX(total_amount)
    FROM (
        SELECT o2.order_id, SUM(p2.product_price) AS total_amount
        FROM `order` o2
        JOIN order_details od2 ON o2.order_id = od2.order_id
        JOIN products p2 ON od2.product_id = p2.product_id
        WHERE o2.user_id = u.user_id
        GROUP BY o2.order_id
    ) AS max_order
);


9.
SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_amount, COUNT(od.product_id) AS number_of_products
FROM users u
JOIN `order` o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id, u.user_name, o.order_id
HAVING total_amount = (
    SELECT MIN(total_amount)
    FROM (
        SELECT o2.order_id, SUM(p2.product_price) AS total_amount
        FROM `order` o2
        JOIN order_details od2 ON o2.order_id = od2.order_id
        JOIN products p2 ON od2.product_id = p2.product_id
        WHERE o2.user_id = u.user_id
        GROUP BY o2.order_id
    ) AS min_order
);


10.
SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS total_amount, COUNT(od.product_id) AS number_of_products
FROM users u
JOIN `order` o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id, u.user_name, o.order_id
HAVING number_of_products = (
    SELECT MAX(number_of_products)
    FROM (
        SELECT o2.order_id, COUNT(od2.product_id) AS number_of_products
        FROM `order` o2
        JOIN order_details od2 ON o2.order_id = od2.order_id
        WHERE o2.user_id = u.user_id
        GROUP BY o2.order_id
    ) AS max_order
);
