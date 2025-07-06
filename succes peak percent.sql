
-- success peak percent
--select top 5 * from exped$

  select (count(distinct(case when success1=1 then peakid end) )* 100)/count(distinct(peakid)) 

as pcent_climbed_peak from exped$  