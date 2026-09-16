
/*
   Issue Description: CDM-15743
   Category/ Module  :  Update removal information
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set exitdate = '2020-08-31 00:00:00', updatedby = 'CDM-15743', updatedon = now() where removalid = '199523';
update placement set enddatetime = '2021-03-11 00:00:00', updatedby = 'CDM-15743', updatedon = now()  where placementid = 'fc306e05-b57a-47f8-9f08-dcb35728ec3d';
update personprogramarea set enddate = '2020-08-31 00:00:00', updatedby = 'CDM-15743', updatedon = now() where personprogramid = 'c6e8a3be-3b87-4243-bb6c-9cc1e2386b6c';
