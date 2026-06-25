
/* =====================================================
PROJECT : Electric Vehicle Market Analysis Using MySQL
AUTHOR  : Muhammed Midlaj
DATABASE: MySQL
Skills Used:

- Aggregate Functions
- GROUP BY
- HAVING
- CASE
- Window Functions
===================================================== */

/* =====================================================
STEP 1 : DATABASE SETUP
===================================================== */

DROP DATABASE IF EXISTS ev_analysis;
CREATE DATABASE ev_analysis;
USE ev_analysis;

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

SELECT 'Model Year', COUNT(*) AS total_vehicles FROM electric_vehicle_population_data
GROUP BY 'Model Year' ORDER BY 'Model Year';

SELECT 'Electric Vehicle Type', COUNT(*) AS total_vehicles
FROM electric_vehicle_population_data GROUP BY 'Electric Vehicle Type';

SELECT city, COUNT(*) AS total_vehicles FROM electric_vehicle_population_data 
GROUP BY city ORDER BY total_vehicles DESC LIMIT 10;

SELECT county, COUNT(*) AS total_vehicles FROM electric_vehicle_population_data
GROUP BY county ORDER BY total_vehicles DESC LIMIT 10;

/* =====================================================
STEP 4 : PERFORMANCE ANALYSIS
===================================================== */

SELECT ROUND(AVG('Electric Range'),2) AS avg_range FROM electric_vehicle_population_data;

SELECT make, ROUND(AVG('Electric Range'),2) AS avg_range FROM electric_vehicle_population_data
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



