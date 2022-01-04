-- create a tmp table before export
DROP TABLE IF EXISTS tmp;
CREATE TEMP TABLE tmp AS (
	SELECT c.* ,"total tests", "people vaccinated",
	   "people fully vaccinated", "total boosters", 
	   "stringency index", "handwashing facilities",
	   "hospital beds per thousand",
	   (CAST(c."new cases" AS DECIMAL)/NULLIF((c."total cases"-c."new cases"),0) * 100) AS "case increasing rate",
	   (CAST(c."new deaths" AS DECIMAL)/NULLIF((c."total cases"-c."new cases"),0)* 100) AS "death increasing rate"
	FROM "covid cases(new2)" c
	JOIN "vaccination and facilities" v 
		ON c.date = v.date AND c.location = v.location
);

SELECT * FROM tmp
ORDER BY location,date;

-- cleaning tmp table
UPDATE tmp 
SET "case increasing rate" = ROUND("case increasing rate",5),
	"death increasing rate" = ROUND("death increasing rate",5);
	
UPDATE tmp
SET "case increasing rate" = 0
WHERE "case increasing rate" IS NULL;

UPDATE tmp
SET "death increasing rate" = 0 
WHERE "death increasing rate" IS NULL;

UPDATE tmp
SET "death increasing rate" = 0 
WHERE "death increasing rate" < 0;

UPDATE tmp
SET "case increasing rate" = 0 
WHERE "case increasing rate" < 0;

-- exporting
COPY (
	SELECT * FROM tmp
) TO 'D:\CODE\python\My_covid_project\Data\table for finding correlation.csv' WITH CSV HEADER



