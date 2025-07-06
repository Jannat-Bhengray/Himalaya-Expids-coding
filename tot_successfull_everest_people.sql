--use [mountains+expeds]

/*select   * from exped$ 
where peakid like '%Ever%' and success1=1 or success2=1 or success3=1 or success4=1*/
 

/*select    YEAR, count(*) as tot_success from exped$ 
where peakid = 'Ever' and success1=1 or success2=1 or success3=1 or success4=1
group by  YEAR order  by tot_success desc*/

--How many people have successfully climbed Mount Everest?

select   count(*) as tot_succ_count from members$ where peakid='EVER' and success=1 

--pi chart with succesful and unsuccesful everst count