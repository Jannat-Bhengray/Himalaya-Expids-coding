--use [mountains+expeds]
--select top 5 * from exped$

with cte as(
select  year,season, count(success1)as suc_count, 
ROW_NUMBER() over(partition by year order by count(success1) desc) as rnk_per_season
 from exped$ where success1=1 group by year , season ) 

 select year, season, suc_count, rnk_per_season from cte where rnk_per_season<=2 order by rnk_per_season asc , suc_count desc

 --autumn and spring best season

 
 --succ rate per year
  SELECT 
  year,
  COUNT(*) AS total_expeditions,
  COUNT(CASE WHEN success1 = 1 THEN 1 END) AS successful_expeditions,
 -- COUNT(*) - COUNT(CASE WHEN success1 = 1 THEN 1 END) AS unsuccessful_expeditions,
  CAST(COUNT(CASE WHEN success1 = 1 THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS success_rate_percent,
  count(case when accidents!='None' then 1 end) as tot_acc
FROM exped$  
GROUP BY year having  CAST(COUNT(CASE WHEN success1 = 1 THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2))>70
ORDER BY success_rate_percent DESC; 

--succ rate per season
 SELECT 
  season,
  COUNT(*) AS total_expeditions,
  COUNT(CASE WHEN success1 = 1 THEN 1 END) AS successful_expeditions,
  
  CAST(COUNT(CASE WHEN success1 = 1 THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS success_rate_percent,
  count(case when accidents!='None' then 1 end) as tot_acc
FROM exped$  
GROUP BY season
--having  CAST(COUNT(CASE WHEN success1 = 1 THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2))>70
ORDER BY success_rate_percent DESC; -- or ASC if you want to see worst years first

 