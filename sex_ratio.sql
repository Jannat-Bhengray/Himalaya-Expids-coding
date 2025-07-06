--use [mountains+expeds]

select sex ,count(*) as tot_climber_no from members$ group by sex order by tot_climber_no desc

--select sex ,count(*) as succ_no from members$ where success=1 group by sex order by succ_no desc

select sex ,(count(  case when success=1 then sex end)*100)/count(*) as success_percent_sex from members$  
group by sex order by success_percent_sex desc


 select top 5* from members$