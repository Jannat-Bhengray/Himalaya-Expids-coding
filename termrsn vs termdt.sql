--use [mountains+expeds]
--select top 5 * from exped$

--termdate vs termreason

/*select top 5 termdate , count(termdate) as trmdt_count from exped$ where termdate is not null
group by termdate
order by count(termdate) desc 

select top 5 termreason , count(termreason) as trmrsn_count from exped$ where termreason is not null
group by termreason
order by count(termreason) desc  */
 

 WITH date_reason AS (
    SELECT 
        FORMAT(termdate, 'yyyy-MM') AS term_year_month,
        termreason,
        COUNT(*) AS reason_count,
        DENSE_RANK() OVER (
            PARTITION BY FORMAT(termdate, 'yyyy-MM') 
            ORDER BY COUNT(*) DESC
        ) AS reason_rank
    FROM exped$
    WHERE termdate IS NOT NULL AND termreason IS NOT NULL
    GROUP BY FORMAT(termdate, 'yyyy-MM'), termreason
),
top_dates AS (
    SELECT 
        term_year_month,
        SUM(reason_count) AS total_terminations,
        DENSE_RANK() OVER (ORDER BY SUM(reason_count) DESC) AS date_rank
    FROM date_reason
    GROUP BY term_year_month
)
SELECT 
    dr.term_year_month,
    dr.termreason,
    dr.reason_count,
    td.total_terminations,
    dr.reason_rank,
    td.date_rank
FROM date_reason dr
JOIN top_dates td ON dr.term_year_month = td.term_year_month
WHERE td.date_rank <= 5  -- top 5 months
  AND dr.reason_rank <  3 -- top 3 reasons per month
ORDER BY td.date_rank, dr.term_year_month, dr.reason_rank;


