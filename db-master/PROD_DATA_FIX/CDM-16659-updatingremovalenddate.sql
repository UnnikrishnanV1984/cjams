/*
   Issue Description: CDM-16659
   Category/ Module  :  
   Root cause: Updating Removal end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--2021-09-05 16:16:44

update intakeservreqchildremoval set exitdate = '2021-09-01 16:16:44', updatedon =  now(), updatedby = 'CDM-16659' where removalid = '250881';
update personprogramarea set enddate = '2021-09-01 16:16:44', updatedon =  now(), updatedby = 'CDM-16659' where personprogramid = 'faa7ca19-eab2-4ade-94d0-ec5a2e2c0448';
