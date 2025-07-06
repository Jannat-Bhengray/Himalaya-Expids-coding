--use [mountains+expeds]

/*select top 5 * from members$
select top 5 * from exped$

select e.expid,m.membid , m.[full name],(year(e.bcdate)-m.[Birth year] ) as age 
from exped$ as e inner join members$ as m on e.expid=m.expid*/

 WITH member_age AS (
  SELECT
    m.membid,
    m.[FULL Name],
    (e.year - m.[Birth year]) AS age_at_expedition,
    FLOOR((e.year - m.[Birth year]) / 10) * 10 AS age_group_start,
    m.success
  FROM members$ m
  JOIN exped$ e ON m.expid = e.expid
  WHERE 
    m.[Birth year] IS NOT NULL
    AND (e.year - m.[Birth year]) BETWEEN 20 AND 80
)
SELECT top 5 
  CONCAT(age_group_start, '-', age_group_start + 9) AS age_group,
  COUNT(*) AS total_climbers,
  SUM(CASE WHEN success = 1 THEN 1 ELSE 0 END) AS successful_climbs,
  CAST(
    SUM(CASE WHEN success = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
    AS DECIMAL(5,2)
  ) AS success_rate_percent
FROM member_age
GROUP BY age_group_start
ORDER BY success_rate_percent DESC;



