/*
   Issue Description: CDM-15092
   Category/ Module  :  Deleting Living Arrangement Record
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 2020-08-24 00:00:00
update personprogramarea set enddate = null, updatedby = 'CDM-15092', updatedon = now() where personprogramid = '3f86e69f-052a-48f5-87b0-e06d30cf48c3';
