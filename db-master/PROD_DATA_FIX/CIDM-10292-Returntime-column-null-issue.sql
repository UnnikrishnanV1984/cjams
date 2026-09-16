/*
   Issue Description: CDM-10292
  
-- Category/ Module: Returttime column bulk datafix.
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A          

*/

update intakeservreqchildremoval ischr
set returntime = exitdate 
where ischr.intakeservreqchildremovalid is not null and ischr.activeflag = 1 and ischr.returntime is null and ischr.exitdate is not null;
