-- 1.	Create a SQL database containing data related to the case number, primary crime category, crime description, crime location, and arrest status using the dataset.
CREATE DATABASE DATA;
select Case_Number,Primary_Type,Description,Location_Description,Arrest AS Arrest_status from crime_us;
select * from crime_us;

-- 2.	 Make a database in SQL where theft costs more than $500.
SELECT Case_Number, Primary_Type, Description, Location_Description, Arrest as Arrest_status
FROM crime_us
WHERE Primary_Type = 'Theft' AND Description = 'OVER $500';

-- 3 .Determine the overall number of cases for each major category of crime.
SELECT Primary_Type, COUNT(*) AS 'Number_of_cases'
FROM `crime_us`
WHERE Arrest = 'True'
GROUP BY Primary_Type;

-- 4.Apply 1NF normalization to the dataset provided.
CREATE TABLE crimes (
  Case_Number VARCHAR(20) PRIMARY KEY,
  Primary_Type VARCHAR(45),
  Description VARCHAR(100),
  Arrest varchar(45)
  );
CREATE TABLE locations (
  Location_ID INT PRIMARY KEY AUTO_INCREMENT,
  Address VARCHAR(100),
  Latitude DECIMAL(10, 8),
  Longitude DECIMAL(11, 8)
);
CREATE TABLE crime_locations (
  Case_Number VARCHAR(20),
  Location_ID INT,
  PRIMARY KEY (Case_Number, Location_ID),
  FOREIGN KEY (Case_Number) REFERENCES crimes(Case_Number),
  FOREIGN KEY (Location_ID) REFERENCES locations(Location_ID)
);

INSERT INTO crimes (Case_Number, Primary_Type, Description, Arrest)
SELECT DISTINCT Case_Number, Primary_Type, Description,
       CASE WHEN Arrest = 'True' THEN 1 ELSE 0 END AS Arrest
FROM crime_us;

-- Insert data into the `locations` table:
INSERT INTO locations (Address, Latitude, Longitude)
SELECT DISTINCT Location, Latitude, Longitude
FROM crime_us;

-- Insert data into the `crime_locations` table:
INSERT INTO crime_locations (Case_Number, Location_ID)
SELECT DISTINCT cu.Case_Number, l.Location_ID
FROM crime_us cu
JOIN locations l ON cu.Location = l.Address;

SELECT * from crimes;
SELECT * from locations;
SELECT * from crime_locations;