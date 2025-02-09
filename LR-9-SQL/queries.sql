-- queries.sql - SQL-скрипты для лабораторной работы №9

-- 4.1 Запрос: список клиентов с суммарной стоимостью их аренды
SELECT c.full_name,
       SUM(r.rental_days * cr.rental_price_per_day) AS total_rental_cost
FROM Clients c
JOIN Rental r ON c.client_id = r.client_id
JOIN Cars cr ON r.car_id = cr.car_id
GROUP BY c.full_name
ORDER BY total_rental_cost DESC;

-- 4.2 Запрос: список клиентов с суммарной стоимостью их аренды и со средней суммой аренды
WITH OrderTotals AS (
    SELECT r.client_id,
           SUM(r.rental_days * c.rental_price_per_day) AS total_order_value
    FROM Rental r
    JOIN Cars c ON r.car_id = c.car_id
    GROUP BY r.client_id
)
SELECT cl.full_name AS client_name,
       ot.total_order_value AS total_order_cost,
       (SELECT AVG(total_order_value) FROM OrderTotals) AS avg_order_cost
FROM Clients cl
JOIN OrderTotals ot ON cl.client_id = ot.client_id
ORDER BY ot.total_order_value DESC;

-- 4.3 Запрос: клиент с наибольшей суммарной стоимостью аренды
SELECT c.full_name,
       SUM(r.rental_days * cr.rental_price_per_day) AS total_rental_cost
FROM Clients c
JOIN Rental r ON c.client_id = r.client_id
JOIN Cars cr ON r.car_id = cr.car_id
GROUP BY c.full_name
ORDER BY total_rental_cost DESC
LIMIT 1;

-- 4.4 Запрос: аренда клиента с наибольшими затратами
WITH OrderTotals AS (
    SELECT r.client_id,
           SUM(r.rental_days * c.rental_price_per_day) AS total_order_value
    FROM Rental r
    JOIN Cars c ON r.car_id = c.car_id
    GROUP BY r.client_id
),
TopClient AS (
    SELECT client_id FROM OrderTotals ORDER BY total_order_value DESC LIMIT 1
)
SELECT r.rental_id AS order_number,
       (r.rental_days * c.rental_price_per_day) AS order_cost
FROM Rental r
JOIN Cars c ON r.car_id = c.car_id
WHERE r.client_id = (SELECT client_id FROM TopClient)
ORDER BY order_cost ASC;

-- 4.5 Запрос: клиенты, чья аренда превышает среднюю стоимость
WITH OrderTotals AS (
    SELECT r.client_id,
           SUM(r.rental_days * c.rental_price_per_day) AS total_order_value
    FROM Rental r
    JOIN Cars c ON r.car_id = c.car_id
    GROUP BY r.client_id
),
AvgOrderTotal AS (
    SELECT AVG(total_order_value) AS avg_order_value FROM OrderTotals
)
SELECT cl.full_name AS client_name,
       ot.total_order_value AS total_order_cost,
       (SELECT avg_order_value FROM AvgOrderTotal) AS avg_order_cost
FROM Clients cl
JOIN OrderTotals ot ON cl.client_id = ot.client_id
WHERE ot.total_order_value > (SELECT avg_order_value FROM AvgOrderTotal)
ORDER BY ot.total_order_value DESC;
