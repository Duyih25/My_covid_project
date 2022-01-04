DROP TABLE IF EXISTS PUBLIC."covid cases"

CREATE TABLE IF NOT EXISTS PUBLIC."covid cases" (
	continent VARCHAR(15),
	location VARCHAR(50),
	"date" DATE,
	"population" BIGINT,
	"total cases" INT,
	"new cases" INT,
	"total deaths" INT,
	"new deaths" INT,
	"icu patients" INT,
	"hosp patients" INT
)

COPY PUBLIC."covid cases" FROM 'D:\CODE\python\My_covid_project\Data\covid cases.csv' WITH CSV HEADER

SELECT * FROM "covid cases"

----- Data cleaning for "continent" column ----
SELECT DISTINCT(location) FROM "covid cases"
WHERE continent IS NULL
 
UPDATE "covid cases"
SET continent = location
WHERE continent IS NULL AND location IN ('Oceania','Asia','Africa','Europe','North America','South America')

-- check after cleaning
SELECT DISTINCT(location) FROM "covid cases"
WHERE continent = location

SELECT DISTINCT(location) FROM "covid cases"
WHERE continent != location AND location IN ('Oceania','Asia','Africa','Europe','North America','South America')


----- cleaning "population" column ----

WITH myVar(increasing_rate) AS (
	VALUES ((326000.0/286257-1)/(2017-2011))
)
SELECT increasing_rate FROM myVar;

DO $$
DECLARE myvar DECIMAL;
BEGIN 
	SELECT (326000.0/286257-1)/(2017-2011) INTO myvar;
	DROP TABLE IF EXISTS tmp;
	CREATE TEMP TABLE tmp (hihi DECIMAL);
	INSERT INTO  tmp (hihi) VALUES(myvar);
END $$;
-- pop in Northern Cyprus is 286,257 in 2011 and 326,000 in 2017 so it increase about 

SELECT * FROM tmp;

UPDATE "covid cases"
SET population = 326000*POWER((SELECT ROUND(hihi,2)+1 FROM tmp),(2020-2017))
WHERE location = 'Northern Cyprus'

SELECT * FROM "covid cases"
WHERE location = 'Northern Cyprus'

-------- cleaning "total cases" and "total deaths" column ----

UPDATE "covid cases"
SET "total cases" = 0 WHERE "total cases" IS NULL;

UPDATE "covid cases"
SET "total deaths" = 0 WHERE "total deaths" IS NULL;

SELECT * FROM "covid cases" WHERE "total cases" = 0

---- Drop unusable information----

SELECT location,MAX("total cases") as col_a,MAX("total deaths") as col_b FROM "covid cases"
GROUP BY "location"
HAVING MAX("total cases")=0 AND MAX("total deaths") = 0;

DELETE FROM "covid cases"
WHERE "location" IN (
	SELECT location FROM "covid cases"
	GROUP BY "location"
	HAVING MAX("total cases")=0 AND MAX("total deaths") = 0
)
RETURNING *;

------ cleaning "icu patients" and "hosp patients" column----

UPDATE "covid cases"
SET "icu patients" = 0 WHERE "icu patients" IS NULL;

UPDATE "covid cases"
SET "hosp patients" = 0 WHERE "hosp patients" IS NULL;

------ check "new cases" column-----

SELECT col_a, col_b FROM (
	SELECT SUM("new cases") OVER(PARTITION BY "location"
	ORDER BY "date") col_a, "total cases" col_b FROM "covid cases"
) tmp
WHERE col_a != col_b
--> result: 11k lines -> need to clean

-- try to create a new column better than "new cases" column
SELECT col_a,col_c FROM(
	SELECT col_a, 
	SUM(CASE WHEN col_b IS NOT NULL THEN col_b ELSE col_a END) OVER (PARTITION BY location ORDER BY date) col_c 
	FROM
		(
			SELECT "new cases",date,location, "total cases" col_a,
			"total cases"-LEAD("total cases",-1) OVER (PARTITION BY location ORDER BY date) col_b
			FROM "covid cases"
		) tmp
	) tmp2
	WHERE col_a != col_c
	--> result: 0 rows -> right


---- CREATE A NEW TABLE WITH CORRECT "new cases" COLUMN
CREATE TABLE "covid cases(new)" (LIKE "covid cases" INCLUDING ALL);
ALTER TABLE "covid cases(new)"
ADD "new cases after cleaning" INT

INSERT INTO  "covid cases(new)"
SELECT *,
"total cases"-LEAD("total cases",-1) OVER (PARTITION BY location ORDER BY date)
FROM "covid cases"

UPDATE "covid cases(new)" 
SET "new cases after cleaning" = "total cases"
WHERE "new cases after cleaning" IS NULL

-- check the last time
SELECT a1, "total cases" FROM (
	SELECT "total cases", SUM("new cases after cleaning") OVER (partition by location ORDER BY date) a1
	FROM "covid cases(new)"
	) T1
	WHERE a1 != "total cases"


------ check "new deaths" column-----

SELECT col_a, col_b FROM (
	SELECT SUM("new deaths") OVER(PARTITION BY "location"
	ORDER BY "date") col_a, "total deaths" col_b FROM "covid cases"
) tmp
WHERE col_a != col_b
--> result :4k lines -> need to clean

-- try to create a new column better than "new deaths" column
SELECT col_a,col_c FROM(
	SELECT col_a, 
	SUM(CASE WHEN col_b IS NOT NULL THEN col_b ELSE col_a END) OVER (PARTITION BY location ORDER BY date) col_c 
	FROM
		(
			SELECT "new deaths",date,location, "total deaths" col_a,
			"total deaths"-LEAD("total deaths",-1) OVER (PARTITION BY location ORDER BY date) col_b
			FROM "covid cases"
		) tmp
	) tmp2
	WHERE col_a != col_c
	--> result: 0 rows -> right


---- CREATE A NEW TABLE WITH CORRECT "new deaths"
CREATE TABLE "covid cases(new2)" (LIKE "covid cases(new)" INCLUDING ALL);
ALTER TABLE "covid cases(new2)"
ADD "new deaths after cleaning" INT

INSERT INTO  "covid cases(new2)"
SELECT *,
"total deaths"-LEAD("total deaths",-1) OVER (PARTITION BY location ORDER BY date)
FROM "covid cases(new)"

SELECT * FROM "covid cases(new2)"

UPDATE "covid cases(new2)" 
SET "new deaths after cleaning" = "total deaths"
WHERE "new deaths after cleaning" IS NULL

-- check the last time
SELECT a1, "total deaths" FROM (
	SELECT "total deaths", SUM("new deaths after cleaning") OVER (partition by location ORDER BY date) a1
	FROM "covid cases(new2)"
	) T1
	WHERE a1 != "total deaths"
	--> true

SELECT * FROM "covid cases(new2)"

UPDATE "covid cases(new2)"
SET "new cases" = "new cases after cleaning", "new deaths" = "new deaths after cleaning"

ALTER TABLE "covid cases(new2)"
DROP COLUMN "new cases after cleaning", 
DROP COLUMN "new deaths after cleaning"





