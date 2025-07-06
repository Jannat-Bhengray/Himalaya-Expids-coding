 
 
 --select top 5 * from members$
 --select top 5 * from exped$ 

 --most o2 use reason 
  -- remove 'From ' if it’s at the start
 SELECT 
  TOP 9 
  CASE 
    WHEN LEFT(mo2note, 5) = 'From ' THEN SUBSTRING(mo2note, 6, LEN(mo2note))
    ELSE mo2note
  END AS cleaned_note,
  COUNT(CASE WHEN mo2used = 1 OR mo2climb = 1 OR mo2descent = 1 OR mo2sleep = 1 OR mo2medical = 1 THEN 1 END) AS tot_o2_use
FROM members$
WHERE mo2note != 'NULL'
GROUP BY 
  CASE 
    WHEN LEFT(mo2note, 5) = 'From ' THEN SUBSTRING(mo2note, 6, LEN(mo2note))
    ELSE mo2note
  END
ORDER BY tot_o2_use DESC;


--most o2 use person
  select top 5 [FULL Name], count(case when mo2used=1 or mo2climb=1 or mo2descent=1 or mo2sleep=1 or mo2medical=1 then 1 end) as tot_o2_use 
from members$  group by [FULL Name] order by tot_o2_use desc

--most o2 used expid 
  select top 5 expid, count(case when mo2used=1 or mo2climb=1 or mo2descent=1 or mo2sleep=1 or mo2medical=1 then 1 end) as tot_o2_use 
from members$  group by expid order by tot_o2_use desc

-- die or not?
  SELECT TOP 30 
  [FULL Name],
  COUNT(CASE WHEN mo2used = 1 OR mo2climb = 1 OR mo2descent = 1 OR mo2sleep = 1 OR mo2medical = 1 THEN 1 END) AS tot_o2_use,
  MAX(CASE WHEN death = 1 THEN 1 ELSE 0 END) AS ever_died
FROM members$
GROUP BY [FULL Name]
ORDER BY tot_o2_use DESC;

--exp of die
 SELECT TOP 7
  [FULL Name],
  COUNT(CASE WHEN mo2used = 1 OR mo2climb = 1 OR mo2descent = 1 OR mo2sleep = 1 OR mo2medical = 1 THEN 1 END) AS tot_o2_use,
  MAX(CASE WHEN death = 1 THEN 1 ELSE 0 END) AS ever_died,
  MAX(CASE WHEN death = 1 THEN expid END) AS death_expid
FROM members$
GROUP BY [FULL Name]
ORDER BY tot_o2_use DESC;


--better relation for exp , die, o2 etc
 WITH o2_usage AS (
  SELECT
    CASE 
      WHEN mo2used = 1 OR mo2climb = 1 OR mo2descent = 1 OR mo2sleep = 1 OR mo2medical = 1 
        THEN 'Used O2'
      ELSE 'No O2'
    END AS o2_group,
    death
  FROM members$
)
SELECT
  o2_group,
  COUNT(*) AS total_climbers,
  SUM(CASE WHEN death = 1 THEN 1 ELSE 0 END) AS total_deaths,
  CAST(
    SUM(CASE WHEN death = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
    AS DECIMAL(5,2)
  ) AS death_rate_percent
FROM o2_usage
GROUP BY o2_group;



