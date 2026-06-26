
/* =====================================================
PROJECT : Electric Vehicle Market Analysis Using MySQL
AUTHOR  : Muhammed Midlaj
DATABASE: MySQL
Skills Used:

- Data Exploration
- Aggregate Functions
- GROUP BY
- HAVING
- CASE
- Window Functions
- Database Normalization
- Primary Key
- Foreign Key
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN

===================================================== */



/* =====================================================
STEP 1 : DATABASE SETUP
===================================================== */


CREATE DATABASE IF NOT EXISTS ev_analysis;
USE ev_analysis;

DROP TABLE IF EXISTS registrations;
DROP TABLE IF EXISTS vehicle_models;
DROP TABLE IF EXISTS manufacturers;
/* =====================================================
STEP 2 : DATASET EXPLORATION
===================================================== */

SELECT COUNT(*) AS total_vehicles FROM electric_vehicle_population_data;
SHOW COLUMNS FROM electric_vehicle_population_data;

/* =====================================================
STEP 3 : BASIC DATA ANALYSIS
===================================================== */

SELECT COUNT(DISTINCT make) AS total_manufacturers FROM electric_vehicle_population_data;

SELECT COUNT(DISTINCT model) AS total_models FROM electric_vehicle_population_data;

SELECT make, COUNT(*) AS total_vehicles FROM electric_vehicle_population_data 
GROUP BY make ORDER BY total_vehicles DESC LIMIT 10;

SELECT model, COUNT(*) AS registrations FROM electric_vehicle_population_data 
GROUP BY model ORDER BY registrations DESC LIMIT 10; 

SELECT `Model Year`, COUNT(*) AS total_vehicles FROM electric_vehicle_population_data
GROUP BY `Model Year` ORDER BY `Model Year`;

SELECT `Electric Vehicle Type`, COUNT(*) AS total_vehicles
FROM electric_vehicle_population_data GROUP BY `Electric Vehicle Type`;

SELECT city, COUNT(*) AS total_vehicles FROM electric_vehicle_population_data 
GROUP BY city ORDER BY total_vehicles DESC LIMIT 10;

SELECT county, COUNT(*) AS total_vehicles FROM electric_vehicle_population_data
GROUP BY county ORDER BY total_vehicles DESC LIMIT 10;

/* =====================================================
STEP 4 : PERFORMANCE ANALYSIS
===================================================== */

SELECT ROUND(AVG(`Electric Range`),2) AS avg_range FROM electric_vehicle_population_data;

SELECT make, ROUND(AVG(`Electric Range`),2) AS avg_range
FROM electric_vehicle_population_data
GROUP BY make ORDER BY avg_range DESC LIMIT 10;

SELECT make, model, COUNT(*) AS registrations FROM electric_vehicle_population_data
GROUP BY make, model ORDER BY registrations DESC;

/* =====================================================
STEP 5 : ADVANCED SQL ANALYSIS
===================================================== */

SELECT make, COUNT(*) AS total_vehicles FROM electric_vehicle_population_data
GROUP BY make HAVING COUNT(*) > 1000 ORDER BY total_vehicles DESC;

SELECT make, COUNT(*) AS total_vehicles,
RANK() OVER (ORDER BY COUNT(*) DESC) AS manufacturer_rank
FROM electric_vehicle_population_data GROUP BY make;

SELECT make, COUNT(*) AS total_vehicles, CASE
          WHEN COUNT(*) > 10000 THEN 'Market Leader'
          WHEN COUNT(*) > 5000 THEN 'Strong Player'
          ELSE 'Emerging Brand'
       END AS category
FROM electric_vehicle_population_data GROUP BY make ORDER BY total_vehicles DESC;


/* =====================================================
STEP 6 : CREATE MANUFACTURERS TABLE
===================================================== */

CREATE TABLE manufacturers
(manufacturer_id INT AUTO_INCREMENT PRIMARY KEY, make VARCHAR(100) UNIQUE);

INSERT INTO manufacturers(make) SELECT DISTINCT make
FROM electric_vehicle_population_data;

SELECT manufacturer_id, make FROM manufacturers;


/* =====================================================
STEP 7 : CREATE VEHICLE MODELS TABLE
===================================================== */

CREATE TABLE vehicle_models (model_id INT AUTO_INCREMENT PRIMARY KEY, manufacturer_id INT,
    model VARCHAR(100), model_year INT, vehicle_type VARCHAR(100), electric_range INT,
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id));

INSERT INTO vehicle_models (manufacturer_id, model, model_year, vehicle_type, electric_range)

SELECT DISTINCT m.manufacturer_id, e.model, e.`Model Year`, e.`Electric Vehicle Type`, e.`Electric Range`
FROM electric_vehicle_population_data e INNER JOIN manufacturers m ON e.make = m.make;

SELECT model_id, manufacturer_id, model, model_year,
vehicle_type, electric_range FROM vehicle_models;


/* =====================================================
STEP 8 : CREATE REGISTRATIONS TABLE
===================================================== */

CREATE TABLE registrations (registration_id INT AUTO_INCREMENT PRIMARY KEY, model_id INT,
county VARCHAR(100), city VARCHAR(100), state VARCHAR(50), postal_code INT,
FOREIGN KEY(model_id) REFERENCES vehicle_models(model_id));

INSERT INTO registrations (model_id, county, city, state, postal_code)
VALUES
(1,'King','Seattle','WA',98101),
(2,'King','Seattle','WA',98101),
(3,'Travis','Austin','TX',73301),
(4,'Cook','Chicago','IL',60601),
(5,'Santa Clara','San Jose','CA',95110),
(6,'Maricopa','Phoenix','AZ',85001);

SELECT * FROM registrations;


/* =====================================================
STEP 9 : INNER JOIN
===================================================== */

SELECT m.make, v.model FROM vehicle_models v
INNER JOIN manufacturers m ON v.manufacturer_id = m.manufacturer_id;


/* =====================================================
STEP 10 : LEFT JOIN
===================================================== */

SELECT m.make, v.model FROM manufacturers m
LEFT JOIN vehicle_models v ON m.manufacturer_id = v.manufacturer_id;


/* =====================================================
STEP 11 : RIGHT JOIN
===================================================== */

SELECT m.make, v.model FROM manufacturers m
RIGHT JOIN vehicle_models v ON m.manufacturer_id = v.manufacturer_id;


/* =====================================================
STEP 12 : THREE TABLE JOIN
===================================================== */

SELECT m.make, v.model, r.city, r.state
FROM manufacturers m INNER JOIN vehicle_models v ON m.manufacturer_id = v.manufacturer_id 
INNER JOIN registrations r ON v.model_id = r.model_id;


/* =====================================================
STEP 13 : TOTAL REGISTRATIONS BY MANUFACTURER
===================================================== */

SELECT m.make, COUNT(*) AS total_registrations
FROM registrations r INNER JOIN vehicle_models v
ON r.model_id = v.model_id
INNER JOIN manufacturers m ON v.manufacturer_id = m.manufacturer_id GROUP BY m.make;


/* =====================================================
STEP 14 : AVERAGE ELECTRIC RANGE BY MANUFACTURER
===================================================== */

SELECT m.make, ROUND(AVG(v.electric_range),2) AS average_range
FROM vehicle_models v INNER JOIN manufacturers m
ON v.manufacturer_id = m.manufacturer_id GROUP BY m.make;


/* =====================================================
STEP 15 : CITY-WISE REGISTRATIONS
===================================================== */

SELECT city, COUNT(*) AS total_registrations FROM registrations
GROUP BY city ORDER BY total_registrations DESC;


/* =====================================================

PROJECT COMPLETED

===================================================== */

