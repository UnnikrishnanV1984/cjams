/*
   Issue Description: CDM-14595
   Category/ Module  :  child removal
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2020-07-04 23:59:00
update intakeservreqchildremoval set exitdate = null, updatedby = 'CDM-14595', updatedon = now() where removalid = '70963';

-- 2020-07-04 00:00:00
update personprogramarea set enddate = null ,updatedby = 'CDM-14595', updatedon = now() where personprogramid = '1652e18f-056d-4d15-a772-bf088a7de96a';