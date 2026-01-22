# STEP 1
USE green;

#Safe Mode
SET sql_safe_updates = 0;

CREATE TABLE IF NOT EXISTS countries (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(255) NOT NULL UNIQUE
);

#IGNORE allows a row creation t be skipped if it already exists (so if Belgium already exists it skipps creating it again)
INSERT IGNORE INTO countries (country)
VALUES
('Belgium'), ('Bulgaria'), ('Czechia'), ('Denmark'), ('Germany'),
('Estonia'), ('Ireland'), ('Greece'), ('Spain'), ('France'),
('Croatia'), ('Italy'), ('Cyprus'), ('Latvia'), ('Lithuania'),
('Luxembourg'), ('Hungary'), ('Malta'), ('Netherlands'), ('Austria'),
('Poland'), ('Portugal'), ('Romania'), ('Slovenia'), ('Slovakia'),
('Finland'), ('Sweden'), ('Iceland'), ('Liechtenstein'), ('Norway'),
('Switzerland'), ('United Kingdom'), ('Serbia'), ('Türkiye');

#STEP 2 - CLEAN UP
#Happiness
DELETE h
	FROM happiness AS h
	LEFT JOIN countries AS c 
	ON h.country = c.country
	WHERE c.country_id IS NULL;

ALTER TABLE happiness
	RENAME COLUMN ï»¿year TO year,
    MODIFY COLUMN year INT NOT NULL,
    MODIFY COLUMN country VARCHAR(255) NOT NULL,
    MODIFY COLUMN happiness_index FLOAT,
    ADD COLUMN country_id INT;

UPDATE happiness AS h
JOIN countries AS c
ON h.country = c.country
SET h.country_id = c.country_id;

ALTER TABLE happiness
	ADD PRIMARY KEY (country_id, year),
    ADD CONSTRAINT fk_happiness_country 
    FOREIGN KEY (country_id) 
	REFERENCES countries(country_id);

#Health
UPDATE health
	SET country = 'Türkiye'
	WHERE country = 'TÃ¼rkiye';

DELETE he
FROM health AS he
LEFT JOIN countries AS c 
ON he.country = c.country
WHERE c.country_id IS NULL;

ALTER TABLE health
    MODIFY COLUMN year INT NOT NULL,
    MODIFY COLUMN country VARCHAR(255) NOT NULL,
    MODIFY COLUMN good_health_percentage FLOAT,
	ADD COLUMN country_id INT;

UPDATE health AS he
JOIN countries AS c 
ON he.country = c.country
SET he.country_id = c.country_id;

ALTER TABLE health
    ADD PRIMARY KEY (country_id, year),
    ADD CONSTRAINT fk_health_country 
    FOREIGN KEY (country_id) 
    REFERENCES countries(country_id);

#Life
DELETE l
FROM life AS l
LEFT JOIN countries AS c 
ON l.country = c.country
WHERE c.country_id IS NULL;
    
ALTER TABLE life
	RENAME COLUMN ï»¿year TO year,
	MODIFY COLUMN year INT NOT NULL,
    MODIFY COLUMN country VARCHAR(255) NOT NULL,
    MODIFY COLUMN life_expectancy FLOAT,
    ADD COLUMN country_id INT;
    
UPDATE life AS l
JOIN countries AS c 
ON l.country = c.country
SET l.country_id = c.country_id;

ALTER TABLE life
    ADD PRIMARY KEY (country_id, year),
    ADD CONSTRAINT fk_life_country 
    FOREIGN KEY (country_id) 
    REFERENCES countries(country_id);

#NDVI
DELETE n
FROM ndvi AS n
LEFT JOIN countries AS c 
ON n.country = c.country
WHERE c.country_id IS NULL;

ALTER TABLE ndvi 
	MODIFY COLUMN year INT NOT NULL,
    RENAME COLUMN country_na TO country,
    MODIFY COLUMN country VARCHAR(255) NOT NULL,
    MODIFY COLUMN ndvi FLOAT,
    ADD COLUMN country_id INT;
    
UPDATE ndvi AS n
JOIN countries AS c 
ON n.country = c.country
SET n.country_id = c.country_id;

ALTER TABLE ndvi
    ADD PRIMARY KEY (country_id, year),
    ADD CONSTRAINT fk_ndvi_country 
    FOREIGN KEY (country_id) 
    REFERENCES countries(country_id);

#Population
DELETE p
FROM population AS p
LEFT JOIN countries AS c 
ON p.country = c.country
WHERE c.country_id IS NULL;

ALTER TABLE population
	RENAME COLUMN ï»¿year TO year;
    
ALTER TABLE population
	MODIFY COLUMN year INT NOT NULL,
    MODIFY COLUMN country VARCHAR(255) NOT NULL,
    ADD COLUMN country_id INT;
    
UPDATE population AS p
JOIN countries AS c 
ON p.country = c.country
SET p.country_id = c.country_id;

ALTER TABLE population
    ADD PRIMARY KEY (country_id, year),
    ADD CONSTRAINT fk_population_country 
    FOREIGN KEY (country_id) 
    REFERENCES countries(country_id);

UPDATE population
	SET population_density = REPLACE(population_density, ',', '');

UPDATE population
	SET population_density = NULL
	WHERE population_density = '';

ALTER TABLE population
	MODIFY population_density DECIMAL(10,2) NULL;
    
SELECT * FROM population;

#Suicide
DELETE s
FROM suicide AS s
LEFT JOIN countries AS c 
ON s.country = c.country
WHERE c.country_id IS NULL;

ALTER TABLE suicide
	RENAME COLUMN ï»¿year TO year,
	MODIFY COLUMN year INT NOT NULL,
    MODIFY COLUMN country VARCHAR(255) NOT NULL,
    MODIFY COLUMN suicide_rate FLOAT,
    ADD COLUMN country_id INT;
    
UPDATE suicide AS s
JOIN countries AS c 
ON s.country = c.country
SET s.country_id = c.country_id;

ALTER TABLE suicide
    ADD PRIMARY KEY (country_id, year),
    ADD CONSTRAINT fk_suicide_country 
    FOREIGN KEY (country_id) 
    REFERENCES countries(country_id);

#Temp
DELETE t
FROM temp AS t
LEFT JOIN countries AS c 
ON t.country = c.country
WHERE c.country_id IS NULL;

CREATE TABLE temp_clean AS
	SELECT *
	FROM temp
	WHERE year >= 2015;

RENAME TABLE temp TO temp_raw, temp_clean TO temp;

ALTER TABLE temp 
	RENAME COLUMN TIME_PERIOD TO year,
	MODIFY COLUMN year INT NOT NULL,
	RENAME COLUMN REF_AREA_LABEL TO country,
    MODIFY COLUMN country VARCHAR(255) NOT NULL,
	RENAME COLUMN OBS_VALUE TO avg_mean_temp,
    MODIFY COLUMN avg_mean_temp FLOAT,
    ADD COLUMN country_id INT;

CREATE TABLE temp_select AS
SELECT  year, country, avg_mean_temp, country_id
FROM temp;

UPDATE temp_select AS t
JOIN countries AS c 
ON t.country = c.country
SET t.country_id = c.country_id;

ALTER TABLE temp_select
    ADD PRIMARY KEY (country_id, year),
    ADD CONSTRAINT fk_temp_country 
    FOREIGN KEY (country_id) 
    REFERENCES countries(country_id);

DROP TABLE temp;
RENAME TABLE temp_select TO temp;


#Merge All Tables
SELECT n.year, c.country, happiness_index, good_health_percentage, life_expectancy, ndvi, population_density, suicide_rate, avg_mean_temp;

CREATE TABLE tableau_exp AS
SELECT n.year, c.country, n.ndvi, h.happiness_index, he.good_health_percentage, l.life_expectancy, p.population_density, s.suicide_rate, t.avg_mean_temp

FROM ndvi AS n
JOIN countries AS c
ON c.country_id = n.country_id

LEFT JOIN happiness AS h
ON h.country_id = n.country_id
AND h.year = n.year

LEFT JOIN health AS he
ON he.country_id = n.country_id
AND he.year = n.year

LEFT JOIN life AS l
ON l.country_id = n.country_id
AND l.year = n.year

LEFT JOIN population AS p
ON p.country_id = n.country_id
AND p.year = n.year

LEFT JOIN suicide AS s
ON s.country_id = n.country_id
AND s.year = n.year

LEFT JOIN temp AS t
ON t.country_id = n.country_id
AND t.year = n.year;

SELECT * FROM tableau_exp;