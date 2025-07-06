--use [mountains+expeds]
--select * from members$ where mo2used=1
 select   count(case when mo2used=1 or mo2climb=1 or mo2descent=1 or mo2sleep=1 or mo2medical=1 then 1 end) as tot_o2_use 
from members$  

SELECT  
  COUNT(
    CASE 
      WHEN 
        (mo2used=1 OR mo2climb=1 OR mo2descent=1 OR mo2sleep=1 OR mo2medical=1)
        AND death=1 
      THEN 1 
    END
  ) AS tot_o2_death
FROM members$;


