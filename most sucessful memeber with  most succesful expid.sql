--use [mountains+expeds]
--select top 5 * from exped$
 --select top 5 * from members$

/*WITH successful_expeditions AS (
    SELECT expid
    FROM exped$
    WHERE success1 = 1
),
member_success AS (
    SELECT 
        m.membid,
        m.[FULL Name],
        COUNT(*) AS succ_mem_count
    FROM members$ m
    inner JOIN successful_expeditions e ON m.expid = e.expid
    GROUP BY m.membid, m.[FULL Name]
)
SELECT TOP 20 *
FROM member_success
ORDER BY succ_mem_count DESC;*/

/*
WITH successful_expeditions AS (
    SELECT expid
    FROM exped$
    WHERE success1 = 1
),
member_success AS (
    SELECT 
        m.membid,
        m.[FULL Name],
        m.expid,
        COUNT(*) OVER (PARTITION BY m.membid) AS succ_mem_count
    FROM members$ m
    INNER JOIN successful_expeditions e ON m.expid = e.expid
),
ranked_members AS (
    SELECT *,
           DENSE_RANK() OVER (ORDER BY succ_mem_count DESC) AS member_rank
    FROM member_success
)
SELECT *
FROM ranked_members
WHERE member_rank <= 5
ORDER BY member_rank, membid, expid;*/

 select top  5 expid
 
, count(success) as tot_succ 
from members$ where success=1 group by
 
expid
order by tot_succ desc  


select top 7  [full name]
, count(success) as tot_succ 
from members$ where success=1 and expid='EVER24109' or  expid='EVER24115' or  expid='EVER19117'
or expid= 'EVER18166' or  expid='MANA23308'
group by
 [FULL Name] 
order by tot_succ desc
