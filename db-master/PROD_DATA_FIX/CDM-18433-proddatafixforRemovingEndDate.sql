
/*
   Issue Description: CDM-18433
   Category/ Module  : Removing draft Removal end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-09-30 17:00:00
update intakeservreqchildremoval set exitdate  = null, updatedby = 'CDM-18433', updatedon = now() where intakeservreqchildremovalid = '8cc6f8ab-7a70-43c2-880a-46261c7e01b9';
update personprogramarea set enddate = null, updatedby = 'CDM-18433', updatedon = now() where personprogramid = '05ca6624-6157-4261-b2cc-3214aaf331f3';
