
--select top 5 * from exped$

--top 5 successfull citizen
select top 5 citizen, count(citizen) as citizen_count from members$ 
where success=1 
group by citizen order by citizen_count desc

 
 --top 5 most successfull citizen rate
select top 5 citizen, (count(*)-count(case when success=0 then 1 end)) as succ_citizen_count from members$
group by citizen order by succ_citizen_count desc

--top 5 rate but mm making   sence
 SELECT top 7
  citizen,
  COUNT(*) AS total_climbers,
  COUNT(CASE WHEN success = 1 THEN 1 END) AS successful_climbers,
  CAST(
    COUNT(CASE WHEN success = 1 THEN 1 END) * 100.0 / COUNT(*) 
    AS DECIMAL(5,2)
  ) AS success_rate_percent
FROM members$
GROUP BY citizen
HAVING COUNT(*) >= 200  -- skip tiny groups
ORDER BY count(*) DESC;
