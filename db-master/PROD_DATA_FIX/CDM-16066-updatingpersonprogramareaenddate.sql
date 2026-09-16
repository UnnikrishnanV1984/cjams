/*
   Issue Description: CDM-16066
   Category/ Module  :  Removing end date of program assignments
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--2021-08-06 16:42:32
--2021-08-06 16:42:32
update personprogramarea set enddate = null, updatedby = 'CDM-16066', updatedon = now() where personprogramid in ('1e251cf4-977e-4938-a46a-6fc0187ba4b7','858f90d4-3130-41ef-b4e9-6295c8ee5bee');  
 