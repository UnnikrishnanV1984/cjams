/*
   Issue Description: CDM-14977
   Category/ Module  :  Updating Placement End date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 2021-03-01 00:00:00
update placement 
set enddatetime ='2021-02-12 00:00:00', updatedon =now(), updatedby ='CDM-14977'
where placementid ='4de02d3b-7b81-48eb-b622-3f3f2558bed4';

-- 2021-03-01 00:00:00
update placementrevision 
set exitdate ='2021-02-12 00:00:00', updatedon =now(), updatedby ='CDM-14977'
where placementrevisionid in ('769a3232-ff37-4464-883a-4fad28fcf8f9');

--2021-02-28
update tb_placement_validation 
set placement_exit_dt ='2021-02-12'::date, update_user_id ='CDM-14977', update_ts = now()
where placement_validation_id =1951548;
