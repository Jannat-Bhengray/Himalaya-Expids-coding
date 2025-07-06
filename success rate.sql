--use [mountains+expeds]
--select top 5 * from dbo.exped$ 

select top 5 peakid, count(*) climbed_no , sum(cast(isnull(success1,0) as int)) as tot_s 
 ,cast((sum(cast(isnull(success1,0) as float))*100.0)/(count(*)) as decimal(5,2)) as success_rate 
 from exped$ 
group by peakid
order by tot_s desc

select top 9 peakid, approach, count(approach) as approach_count from exped$
group by peakid, approach order by count(approach) desc 


--combining both above query

-- Combine peak stats + top approaches per peak
 WITH peak_stats AS (
  SELECT
    peakid,
    COUNT(*) AS climbed_no,
    SUM(CAST(ISNULL(success1, 0) AS INT)) AS tot_s,
    CAST(
      (SUM(CAST(ISNULL(success1, 0) AS FLOAT)) * 100.0) / COUNT(*)
      AS DECIMAL(5,2)
    ) AS success_rate
  FROM exped$
  GROUP BY peakid
),
top_peaks AS (
  SELECT TOP 5 *
  FROM peak_stats
  ORDER BY tot_s DESC
),
approach_ranks AS (
  SELECT
    peakid,
    approach,
    COUNT(*) AS approach_count,
    ROW_NUMBER() OVER (
      PARTITION BY peakid 
      ORDER BY COUNT(*) DESC
    ) AS approach_rank
  FROM exped$
  WHERE approach != 'NULL'
  GROUP BY peakid, approach
)
SELECT
  p.peakid,
  p.climbed_no,
  p.tot_s,
  p.success_rate,
  a.approach,
  a.approach_count,
  a.approach_rank
FROM top_peaks p
JOIN approach_ranks a
  ON p.peakid = a.peakid
WHERE a.approach_rank <= 3
ORDER BY p.tot_s DESC, p.peakid, a.approach_rank;
