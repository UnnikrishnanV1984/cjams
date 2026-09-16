
/*
   Issue Description: CDM-19062
   Category/ Module  : Removing removal from person program
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-19062', updatedon = now() where 
intakeservreqchildremovalid = 'ca8bc7dc-d335-4b40-94f7-83d8c6afd77c';

-- 2021-11-18
update personprogramarea set enddate = null, updatedby = 'CDM-19062', updatedon = now() where personprogramid = '762dbb42-b6e2-4e58-b4c1-2c7dbb24a131';
