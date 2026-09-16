
/*
   Issue Description: CDM-21816
   Category/ Module  : Prod data fix for removing exit date and OOH PA
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2022-03-11 00:00:00
update personprogramarea set enddate = null, updatedby = 'CDM-21816', updatedon = now() 
where personprogramid = '5de219f8-9291-465b-8c13-249fc297a462';

-- 2022-03-11 10:00:00
update intakeservreqchildremoval set exitdate = null, updatedby = 'CDM-21816', updatedon = now()
where intakeservreqchildremovalid = 'd30a83e0-8366-4651-bb48-115d36cbea81';
