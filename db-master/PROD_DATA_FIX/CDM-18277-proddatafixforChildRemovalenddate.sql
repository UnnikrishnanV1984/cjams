
/*
   Issue Description: CDM-18277
   Category/ Module  : Removing End date for Child Removal and person program
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-06-23 17:00:20
update intakeservreqchildremoval set exitdate = null, updatedby = 'CDM-18277', updatedon = now() where removalid = '193921';
update personprogramarea set activeflag = 0, updatedby = 'CDM-18277', updatedon = now() where personprogramid = 'e56298b0-a3ff-4c2e-8f9b-17091c41df3c';
