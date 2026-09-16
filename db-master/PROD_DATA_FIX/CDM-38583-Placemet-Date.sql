/*
   Issue Description: CDM-38583
   Category/ Module  :  Placement Enddate removal
   Root cause: user requeseted to update placement Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update placement set enddatetime = null, endtime = null, updatedon = now(), updatedby = 'CDM-38583'
where placementid = 'a583d750-82e8-4a37-a890-15672aed88e8'
and activeflag = 1;
-- 2024-04-24 00:00:00.000	10:00
update placementrevision set exitdate = null, exittime = null, updatedon = now(), updatedby = 'CDM-38583' 
where placementid ='a583d750-82e8-4a37-a890-15672aed88e8' and placementrevisionid ='8987b9b7-7ffd-4a0a-9ede-29a4b71e3e21'
and activeflag = 1;


