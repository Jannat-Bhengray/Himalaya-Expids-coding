
--select top 5 * from exped$
--can be used to find the top route tooo
WITH success_approach AS (
    SELECT 
        peakid,
        approach,
        COUNT(*) AS total_attempts,
        SUM(CAST(ISNULL(success1, 0) AS INT)) AS total_successes
    FROM exped$
    WHERE approach IS NOT NULL AND peakid IS NOT NULL
    GROUP BY peakid, approach
),
ranked_routes AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY peakid ORDER BY total_successes DESC) AS approach_rank
    FROM success_approach
)
SELECT top 10 *
FROM ranked_routes
WHERE approach_rank  = 1
ORDER BY total_successes DESC;
