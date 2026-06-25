/*=========================================================
PROJECT : SQL Database Normalization & Joins
AUTHOR  : Muhammed Midlaj
DATABASE: MySQL

Skills Used

- Primary Key
- Foreign Key
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- Aggregate Functions
=========================================================*/

DROP DATABASE IF EXISTS sql_joins_project;
CREATE DATABASE sql_joins_project;
USE sql_joins_project;

CREATE TABLE manufacturers 
(manufacturer_id INT AUTO_INCREMENT PRIMARY KEY, make VARCHAR(100) UNIQUE);

INSERT INTO manufacturers(make) SELECT DISTINCT make FROM electric_vehicle_population_data;

SELECT manufacturer_id, make FROM manufacturers;

CREATE TABLE vehicle_models ( 
        model_id INT AUTO_INCREMENT PRIMARY KEY, manufacturer_id INT, model VARCHAR(100),model_year INT, 
        vehicle_type VARCHAR(100), electric_range INT, FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id));

INSERT INTO vehicle_models ( manufacturer_id, model, model_year, vehicle_type, electric_range)

SELECT DISTINCT m.manufacturer_id, e.model, e.`Model Year`, e.`Electric Vehicle Type`, e.`Electric Range`
FROM electric_vehicle_population_data e INNER JOIN manufacturers m ON e.make=m.make;

SELECT model_id, manufacturer_id, model, model_year, vehicle_type, electric_range FROM vehicle_models;

CREATE TABLE registrations (
registration_id INT AUTO_INCREMENT PRIMARY KEY, model_id INT, county VARCHAR(100), 
city VARCHAR(100), state VARCHAR(50), postal_code INT, FOREIGN KEY(model_id) REFERENCES vehicle_models(model_id)
);

INSERT INTO registrations( model_id, county, city, state, postal_code )
VALUES
(1,'King','Seattle','WA',98101),
(2,'King','Seattle','WA',98101),
(3,'Travis','Austin','TX',73301),
(4,'Cook','Chicago','IL',60601),
(5,'Santa Clara','San Jose','CA',95110),
(6,'Maricopa','Phoenix','AZ',85001);

SELECT m.make, v.model FROM vehicle_models v
INNER JOIN manufacturers m ON v.manufacturer_id=m.manufacturer_id;

SELECT m.make, v.model FROM manufacturers m RIGHT JOIN vehicle_models v ON m.manufacturer_id=v.manufacturer_id;

SELECT m.make, v.model FROM manufacturers m 
LEFT JOIN vehicle_models v ON m.manufacturer_id=v.manufacturer_id;

SELECT m.make, v.model, r.city, r.state FROM manufacturers m
JOIN vehicle_models v ON m.manufacturer_id=v.manufacturer_id JOIN registrations r ON v.model_id=r.model_id;

SELECT m.make, COUNT(*) total FROM registrations r JOIN vehicle_models v ON r.model_id=v.model_id 
JOIN manufacturers m ON v.manufacturer_id=m.manufacturer_id GROUP BY m.make;

SELECT m.make, ROUND(AVG(v.electric_range), 2) AS average_range FROM vehicle_models v
INNER JOIN manufacturers m ON v.manufacturer_id = m.manufacturer_id GROUP BY m.make;

SELECT city, COUNT(*) AS total_registrations FROM registrations GROUP BY city ORDER BY total_registrations DESC;
