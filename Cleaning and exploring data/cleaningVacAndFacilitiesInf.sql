CREATE TABLE IF NOT EXISTS "vaccination and facilities" (
	continent VARCHAR(15),
	location VARCHAR(50),
	"date" DATE,
	population BIGINT,
	"new tests" INT,
	"total tests" BIGINT,
	"total vaccinations" BIGINT,
	"people vaccinated" BIGINT,
	"people fully vaccinated" BIGINT,
	"total boosters" BIGINT,
	"new vaccinations" INT,
	"stringency index" DECIMAL,
	"handwashing facilities" DECIMAL,
	"hospital beds per thousand" DECIMAL
);

COPY "vaccination and facilities" FROM 'D:\CODE\python\My_covid_project\Data\vaccination and facilities.csv'
WITH CSV HEADER;


---- check unuseful information 

SELECT location, MAX("total vaccinations"), MAX("people vaccinated"), 
	   MAX("hospital beds per thousand") 
FROM "vaccination and facilities" 
GROUP BY location
HAVING (MAX("total vaccinations") IS NULL OR MAX("people vaccinated") IS NULL) AND
	   MAX("hospital beds per thousand") IS NULL
	   
--- delete unuseful lines
DELETE FROM "vaccination and facilities" 
WHERE location IN (
	SELECT location
	FROM "vaccination and facilities" 
	GROUP BY location
	HAVING (MAX("total vaccinations") IS NULL OR MAX("people vaccinated") IS NULL) AND
		   MAX("hospital beds per thousand") IS NULL
)


----- Data cleaning for "continent" column ----
SELECT DISTINCT(location) FROM "vaccination and facilities" 
WHERE continent IS NULL;
 
UPDATE "vaccination and facilities"
SET continent = location
WHERE continent IS NULL AND location IN ('Oceania','Asia','Africa','Europe','North America','South America') 


-- check after cleaning
SELECT DISTINCT(location) FROM "vaccination and facilities"
WHERE continent = location


---- cleaning "total tests", "total vaccinations", "people vaccinated", "people fully vaccinated", "total boosters" column

-- find first person was injected in the world
SELECT * FROM "vaccination and facilities"
WHERE "people vaccinated" !=0
ORDER BY date
--> date: 2020-12-01

UPDATE "vaccination and facilities"
SET "total tests" = COALESCE("total tests",0),
	"total vaccinations" = COALESCE("total vaccinations",0),
	"people vaccinated" = COALESCE("people vaccinated",0),
	"people fully vaccinated" = COALESCE("people fully vaccinated",0),
	"total boosters" = COALESCE("total boosters",0)
WHERE date < '2020-12-01'

SELECT * FROM "vaccination and facilities"
ORDER BY date

--- check "total vaccinations" and "total tests" column
SELECT * FROM "vaccination and facilities"
WHERE "total vaccinations" IS NULL
ORDER BY location,"total tests"
--> ~ 50k lines

SELECT * FROM "vaccination and facilities"
WHERE "total tests" IS NULL
ORDER BY location,"total tests"
--> ~ 50k lines

-- Because of many lines have NULL "total tests" and "total vaccinations" so I can't clean "new tests" and "new vaccinations"
--> Drop them
ALTER TABLE "vaccination and facilities"
DROP COLUMN "new tests",
DROP COLUMN "new vaccinations"
	
SELECT * FROM "vaccination and facilities"	
	


