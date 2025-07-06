--use [mountains+expeds]

 --select top 5 * from dbo.exped$ 
--select top 5 * from dbo.peaks$

 
with most_climbed_peak as (
select top 5 peakid, count(peakid) as totl_no_of_peak  from dbo.exped$
where peakid is Not Null 
group by peakid order by totl_no_of_peak desc 
) 
select  m.peakid ,count(e.accidents)as tot_accident   from most_climbed_peak as m inner join exped$ as e on m.peakid=e.peakid 
group by m.peakid
order by tot_accident desc




  