/*
   Issue Description: CDM-15086
   Category/ Module  :  Updating Removal Start Date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



-- 2021-06-14 00:00:00 , 2021-06-14 08:00:00
update intakeservreqchildremoval set removaldate = '2021-06-13 00:00:00', removaltime = '2021-06-13 08:00:00', updatedby = 'CDM-15037', updatedon = now() where removalid = '252287';

-- 2021-06-14 00:00:00
update personprogramarea set startdate = '2021-06-13 00:00:00', updatedby = 'CDM-15037', updatedon = now() where personprogramid = '3ebe294d-ed2d-4d85-89f3-7ddfc7adae5b';
