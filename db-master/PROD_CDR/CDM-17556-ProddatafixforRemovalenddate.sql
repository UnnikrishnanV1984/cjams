/*
  Issue Description: CDM-17556
   Category/ Module  :  Removing Removal end date
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 2021-09-30 10:51:00
update intakeservreqchildremoval set exitdate = null, updatedon = now(), updatedby ='CDM-17556'  where removalid = '180101';
-- 2021-09-30
update personprogramarea set enddate = null, updatedon = now(), updatedby ='CDM-17556' where personprogramid = '3b63d047-4436-4fb2-b6a2-ead090b02c1a';
