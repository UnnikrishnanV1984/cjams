/*
   Issue Description: CDM-16252
   Category/ Module  :  Removing placement end date
   Root cause: user requeseted to update placement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-07-19 00:00:00
update placement set enddatetime = null, endtime = null, updatedon = now(), updatedby = 'CDM-16252' where placementid = '91a1e74c-5113-460f-a747-be89020cbc06' and activeflag = 1;
-- 2021-07-19 00:00:00	10:00
update placementrevision set exitdate = null, exittime = null, updatedon = now(), updatedby = 'CDM-16252' where placementid = '91a1e74c-5113-460f-a747-be89020cbc06' and activeflag = 1;
