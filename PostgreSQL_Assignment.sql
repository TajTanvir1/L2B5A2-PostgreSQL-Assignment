-- Active: 1751386830294@@127.0.0.1@5432@psql_assignment

CREATE DATABASE psql_assignment;

SELECT current_database();

CREATE TABLE rangers(
    ranger_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    region TEXT
);

INSERT INTO rangers (ranger_id, name, region) VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range'),
(4, 'David Brown', 'Eastern Woods'),
(5, 'Eva Black', 'Sunny Plains'),
(6, 'Frank Stone', 'Western Ridge'),
(7, 'Grace Frost', 'Glacier Point'),
(8, 'Henry Moss', 'Pine Barrens'),
(9, 'Isla Gray', 'Desert Edge'),
(10, 'Jack Hunter', 'Ocean Cliffs');


SELECT * FROM rangers;

CREATE TABLE species(
    species_id SERIAL PRIMARY KEY,
    common_name TEXT NOT NULL,
    scientific_name TEXT,
    discovery_date DATE,
    conservation_status TEXT
);

INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
(5, 'Indian Cobra', 'Naja naja', '1758-01-01', 'Least Concern'),
(6, 'Great Hornbill', 'Buceros bicornis', '1825-01-01', 'Near Threatened'),
(7, 'Himalayan Monal', 'Lophophorus impejanus', '1790-01-01', 'Least Concern'),
(8, 'Indian Pangolin', 'Manis crassicaudata', '1822-01-01', 'Endangered'),
(9, 'Gharial', 'Gavialis gangeticus', '1806-01-01', 'Critically Endangered'),
(10, 'Sloth Bear', 'Melursus ursinus', '1791-01-01', 'Vulnerable'),
(11, 'Giant Panda', 'Ailuropoda melanoleuca', '1869-01-01', 'Vulnerable'),
(12, 'Snowy Owl', 'Bubo scandiacus', '1758-01-01', 'Least Concern');


SELECT * FROM species;


CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    species_id INT,
    Foreign Key (species_id) REFERENCES species (species_id),
    ranger_id INT,
    FOREIGN KEY(ranger_id) REFERENCES rangers(ranger_id),
    location TEXT,
    sighting_time TIMESTAMP,
    notes TEXT
);

INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL),
(5, 4, 4, 'Elephant Marsh', '2024-05-20 14:05:00', 'Large herd crossing'),
(6, 5, 5, 'Cobra Rock', '2024-05-22 12:00:00', 'Coiled near trail'),
(7, 6, 6, 'Hornbill Nest Hill', '2024-05-25 06:30:00', 'Nesting pair spotted'),
(8, 7, 7, 'Monal Point', '2024-05-27 08:40:00', 'Bright plumage recorded'),
(9, 8, 8, 'Pangolin Hollow', '2024-05-29 22:15:00', 'Night burrow activity'),
(10, 9, 9, 'Riverbank Cliff', '2024-06-01 17:50:00', 'Rare vocalization recorded'),
(11, 10, 4, 'Sloth Bend Trail', '2024-06-03 11:10:00', 'Observed carrying cubs'),
(12, 2, 3, 'Delta Crossing', '2024-06-04 19:00:00', 'Tracks along mud bank'),
(13, 3, 1, 'Redwood Grove', '2024-06-06 08:05:00', 'Sleeping on branch'),
(14, 4, 7, 'Indigo Plains', '2024-06-07 15:30:00', 'Trumpeting sound heard'),
(15, 5, 6, 'Snake Hollow', '2024-06-09 09:45:00', 'Shedding observed');


SELECT * FROM sightings;


-- Problem 1
-- Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO rangers (ranger_id, name, region) VALUES
(11, 'Derek Fox', 'Coastal Plains');

SELECT * FROM rangers;

-- Problem 2
-- Count unique species ever sighted.
SELECT COUNT(DISTINCT species_id) as unique_species_count from sightings;


-- Problem 3
-- Find all sightings where the location includes "Pass".
SELECT * FROM sightings WHERE location ILIKE '%pass%';


-- Problem 4
-- List each ranger's name and their total number of sightings.
SELECT rangers.name, COUNT(sightings.sighting_id) as total_sightings 
FROM rangers LEFT JOIN sightings on rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.ranger_id, rangers.name;


-- Problem 5
-- List species that have never been sighted.
SELECT species.common_name FROM species
LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE sightings.sighting_id IS NULL;

-- Problem 6
--  Show the most recent 2 sightings.
SELECT species.common_name, sightings.sighting_time, rangers.name FROM sightings 
JOIN species on sightings.species_id = species.species_id
join rangers on sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
limit 2;


-- Problem 7
-- Update all species discovered before year 1800 to have status 'Historic'.
SELECT * FROM species;
UPDATE species set conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';
SELECT * FROM species;



-- Problem 8
-- Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
CREATE OR REPLACE FUNCTION time_of_day(sighting_timestamp TIMESTAMP)
RETURNS TEXT
LANGUAGE plpgsql
AS 
$$
DECLARE hour INT;
BEGIN
   SELECT EXTRACT(HOUR FROM sighting_timestamp) INTO hour;
    IF hour >= 0 AND hour < 12 THEN
        RETURN 'Morning';
    ELSEIF hour >= 12 AND hour < 17 THEN
        RETURN 'Afternoon';
    ELSE
        RETURN 'Evening';
    END IF;
END;
$$;

SELECT sighting_id, time_of_day(sighting_time)
FROM sightings;

-- Problem 9
-- Delete rangers who have never sighted any species
SELECT * FROM rangers;


DELETE FROM rangers where ranger_id not in (
    SELECT DISTINCT ranger_id from sightings
);
SELECT * FROM rangers;

