-- looking at countries with highest infection number per population at the most recent month
SELECT location, MAX("total cases") as total_cases_at_present, population,
MAX(ROUND(CAST("total cases" AS decimal)/population*100, 6)) AS "infection rate (%)"
FROM "covid cases(new2)"
WHERE EXTRACT(MONTH FROM date) = (
	SELECT EXTRACT(MONTH FROM MAX(date)) FROM "covid cases(new2)"
) AND EXTRACT(YEAR FROM date) = (
	SELECT EXTRACT(YEAR FROM MAX(date)) FROM "covid cases(new2)"
) AND "population" IS NOT NULL
Group by location,population
ORDER BY "infection rate (%)" DESC

-- looking at total cases vs total deaths in Vietnam
SELECT location, date, "total cases", "total deaths",
ROUND(CAST("total deaths" AS decimal)/"total cases"*100, 2) AS "death rate (%)"
FROM "covid cases(new2)"
WHERE location = 'Vietnam'
ORDER BY 1,2


-- looking at total cases vs population in Vietnam
SELECT location, date, "total cases", population,
ROUND(CAST("total cases" AS decimal)/population*100, 6) AS "infection rate (%)"
FROM "covid cases(new2)"
WHERE location = 'Vietnam'
ORDER BY 1,2


-- looking at countries with highest death number per population at the most recent month
SELECT location, MAX("total deaths") as total_deaths_at_present, population,
MAX(ROUND(CAST("total deaths" AS decimal)/population*100, 6)) AS "deaths rate (%)"
FROM "covid cases(new2)"
WHERE continent IS NOT NULL 
AND EXTRACT(MONTH FROM date) = (
	SELECT EXTRACT(MONTH FROM MAX(date)) FROM "covid cases(new2)"
) AND EXTRACT(YEAR FROM date) = (
	SELECT EXTRACT(YEAR FROM MAX(date)) FROM "covid cases(new2)"
) AND "population" IS NOT NULL
Group by location,population
ORDER BY  "deaths rate (%)" DESC


-- total death in the world and number of deaths / total cases
SELECT  MAX("total cases"), MAX("total deaths"),
ROUND(CAST(MAX("total deaths") AS decimal)/MAX("total cases")*100, 2) AS "death rate (%)"
FROM "covid cases(new2)"
WHERE location = 'World'
--> sheet 1


-- total death in continents and number of deaths / total cases
SELECT location, MAX("total cases") "total cases", MAX("total deaths") "total deaths",
ROUND(CAST(MAX("total deaths") AS decimal)/MAX("total cases")*100, 2) AS "death rate (%)"
FROM "covid cases(new2)"
WHERE location IN ('Europe','Asia','Oceania','South America','North America','Africa')
GROUP BY location
--> sheet 2


--looking at infection rate in locations
SELECT location, CAST(MAX("total cases") AS DECIMAL)/population*100 "infected rate (%)"
FROM "covid cases(new2)"
WHERE population!=0
GROUP BY location,population
ORDER BY 2 DESC
--> sheet 3

-- looking at total cases and vaccinated people in locations
SELECT d.location,d.continent, MAX(d."total cases") "total cases", MAX(vac."people vaccinated") "people vaccinated"
FROM "vaccination and facilities" vac
INNER JOIN "covid cases(new2)" d ON vac.location = d.location AND vac.date = d.date
WHERE d.continent = d.location
GROUP BY d.location,d.continent
ORDER BY 1,2
--> sheet 4



