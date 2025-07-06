--use [mountains+expeds]
 --select top 5 * from members$
 --select top 5 * from exped$

 --deathclass 
 select top 5 deathclass,count(*) as rsn_count  from members$ where death=1
 group by deathclass order by rsn_count desc

 --deathtype
 select top 5 deathtype,count(*) as rsn_count  from members$ where death=1
 group by deathtype order by rsn_count desc

 --most year death
  select top 7 year( deathdate) as yr,count(*) as dth_count  from members$ where death=1
 group by year(deathdate) order by dth_count desc

 --most month death

 select top 7 month( deathdate) as mnth,count(*) as rsn_count  from members$ where death=1
 group by month(deathdate) order by rsn_count desc

 SELECT
  CASE 
    WHEN MONTH(deathdate) IN (12, 1, 2) THEN 'Winter'
    WHEN MONTH(deathdate) IN (3, 4, 5) THEN 'Spring'
    WHEN MONTH(deathdate) IN (6, 7, 8) THEN 'Summer'
    WHEN MONTH(deathdate) IN (9, 10, 11) THEN 'Autumn'
    ELSE 'Unknown'
  END AS season,
  COUNT(*) AS death_count
FROM members$
WHERE death = 1 AND deathdate IS NOT NULL
GROUP BY 
  CASE 
    WHEN MONTH(deathdate) IN (12, 1, 2) THEN 'Winter'
    WHEN MONTH(deathdate) IN (3, 4, 5) THEN 'Spring'
    WHEN MONTH(deathdate) IN (6, 7, 8) THEN 'Summer'
    WHEN MONTH(deathdate) IN (9, 10, 11) THEN 'Autumn'
    ELSE 'Unknown'
  END
ORDER BY death_count DESC;




--crazy thing
WITH deaths_with_season AS (
  SELECT
    CASE 
      WHEN MONTH(deathdate) IN (12, 1, 2) THEN 'Winter'
      WHEN MONTH(deathdate) IN (3, 4, 5) THEN 'Spring'
      WHEN MONTH(deathdate) IN (6, 7, 8) THEN 'Summer'
      WHEN MONTH(deathdate) IN (9, 10, 11) THEN 'Autumn'
      ELSE 'Unknown'
    END AS season,
    MONTH(deathdate) AS death_month,
    COUNT(*) AS death_count
  FROM members$
  WHERE death = 1 AND deathdate IS NOT NULL
  GROUP BY 
    CASE 
      WHEN MONTH(deathdate) IN (12, 1, 2) THEN 'Winter'
      WHEN MONTH(deathdate) IN (3, 4, 5) THEN 'Spring'
      WHEN MONTH(deathdate) IN (6, 7, 8) THEN 'Summer'
      WHEN MONTH(deathdate) IN (9, 10, 11) THEN 'Autumn'
      ELSE 'Unknown'
    END,
    MONTH(deathdate)
),
ranked_months AS (
  SELECT
    season,
    death_month,
    death_count,
    ROW_NUMBER() OVER (PARTITION BY season ORDER BY death_count DESC) AS rn
  FROM deaths_with_season
),
season_totals AS (
  SELECT
    season,
    SUM(death_count) AS total_deaths
  FROM deaths_with_season
  GROUP BY season
)
SELECT
  s.season,
  s.total_deaths AS death_count,
  DATENAME(month, DATEFROMPARTS(2000, r.death_month, 1)) AS top_dth_mnth_ssn
FROM season_totals s
LEFT JOIN ranked_months r
  ON s.season = r.season AND r.rn = 1
ORDER BY s.total_deaths DESC;


 