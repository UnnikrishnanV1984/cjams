/*
   Issue Description: CDM-16043
   Category/ Module  :  Updating person program area
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update personprogramarea set enddate = '2021-07-01 14:30:00', updatedon = now(),updatedby = 'CDM-16043' where personprogramid = 'e49897a4-b713-41a7-9442-6a88343b9a5e';

-- 2021-07-15
update personprogramarea set enddate = null, updatedby = 'CDM-16043',updatedon = now() where personprogramid = '09157b2e-159f-4515-9397-434bcd56d6c2'
