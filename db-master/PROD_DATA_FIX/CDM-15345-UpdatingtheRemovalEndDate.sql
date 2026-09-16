
/*
   Issue Description: CDM-15345
   Category/ Module  :  Updating the End date for person program and Removal end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- CDM-15345
-- 2020-10-28 00:00:00
update personprogramarea set enddate = null, updatedon = now(), updatedby = 'CDM-15345' where personprogramid  = 'd2592b89-7828-4b3b-98b7-1d53a5ef2f1a';

-- 2020-10-28 10:46:18, 2018-04-11 11:00:00
update intakeservreqchildremoval set exitdate = null,removaltime = null, updatedby ='CDM-15345', updatedon = now() where removalid = '190777';
