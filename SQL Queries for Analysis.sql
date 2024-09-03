
-- ev_population Dataset
SELECT * FROM electric_vehicles.ev_population_data;

-- Total Vehicles by Model Year (From 2010 Onwards):

SELECT Model_Year, COUNT(*) AS Total_Vehicles FROM ev_population_data WHERE 
    Model_Year >= 2010 
    GROUP BY Model_Year 
    ORDER BY Model_Year;
    
-- Basic Summary Statistics (Basic statistics such as average MSRP and the maximum electric range)
SELECT 
    AVG(Base_MSRP) AS Average_MSRP,
    MAX(Electric_Range) AS "Max Electric Range",
    MIN(Electric_Range) AS "Min Electric Range"
FROM ev_population_data;

-- Top 10 Total Vehicles by Make

SELECT Make, COUNT(*) AS Total_Vehicles FROM ev_population_data
	GROUP BY Make
	ORDER BY Total_Vehicles DESC
	LIMIT 10;

-- Top 10 Total Vehicles by Model (Models with the highest number of vehicles.)
SELECT Model, COUNT(*) AS Total_Vehicles FROM ev_population_data
	GROUP BY Model
	ORDER BY Total_Vehicles 
	DESC LIMIT 10;


-- Total Vehicles by CAFV Eligibility

SELECT "Clean_Alternative_Fuel_Vehicle(CAFV)_Eligibility", COUNT(*) AS Total_Vehicles FROM ev_population_data
	GROUP BY "Clean_Alternative_Fuel_Vehicle(CAFV)_Eligibility";

-- Electric Vehicle Distribution by State
SELECT State, COUNT(*) AS Number_of_Vehicles
FROM ev_population_data
GROUP BY State
ORDER BY Number_of_Vehicles DESC;


-- Total BEV Vehicles and % of Total BEV Vehicles

WITH TotalVehicles AS (
    SELECT 
        COUNT(*) AS Total
    FROM 
        ev_population_data
),
BEV_Vehicles AS (
    SELECT 
        COUNT(*) AS BEV_Count
    FROM 
        ev_population_data
    WHERE 
        Electric_Vehicle_Type = 'Battery Electric Vehicle (BEV)'
)
SELECT 
    BEV_Vehicles.BEV_Count,
    (BEV_Vehicles.BEV_Count * 100.0 / TotalVehicles.Total) AS BEV_Percentage
FROM 
    BEV_Vehicles, TotalVehicles;


-- Total PHEV Vehicles and % of Total PHEV Vehicles
WITH TotalVehicles AS (
    SELECT 
        COUNT(*) AS Total
    FROM 
        ev_population_data
),
PHEV_Vehicles AS (
    SELECT 
        COUNT(*) AS PHEV_Count
    FROM 
       ev_population_data
    WHERE 
        Electric_Vehicle_Type = 'Plug-in Hybrid Electric Vehicle (PHEV)'
)
SELECT 
    PHEV_Vehicles.PHEV_Count,
    (PHEV_Vehicles.PHEV_Count * 100.0 / TotalVehicles.Total) AS PHEV_Percentage
FROM 
    PHEV_Vehicles, TotalVehicles;


-- Relationship between electric range and MSRP - Electric Range vs. MSRP

SELECT Electric_Range, Electric_Utility
FROM ev_population_data;

-- Electric Vehicles with Zero MSRP

SELECT Vehicle_ID, Make, Model, Electric_Range
FROM ev_population_data
WHERE Base_MSRP = 0;

-- Comparison of Electric Range and MSRP by Vehicle Type

SELECT Electric_Vehicle_Type,
    AVG(Electric_Range) AS Avg_Electric_Range,
    AVG(Base_MSRP) AS Avg_MSRP
FROM ev_population_data
GROUP BY Electric_Vehicle_Type;