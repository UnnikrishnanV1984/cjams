/*
   Issue Description: CDM-14805
   Category/ Module  :  child removal
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   back up: 2021-06-30 10:00:00
   personprogramarea.enddate: 2021-06-30 10:00:00
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-14914', updatedon = now() where removalid in ('251044','251065');