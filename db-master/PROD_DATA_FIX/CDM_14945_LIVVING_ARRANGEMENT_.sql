/*
   Issue Description: CDM-14945
   Category/ Module  :  Living Arrangement  
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update livingarrangement 
set livingenddate = '2021-02-08 13:05:00.050337', updatedon = now(), updatedby = 'CDM-14945' 
where placementid = 'ed61afcc-271b-486a-abb3-2cde718c7bb8';
update placement 
set enddatetime = '2021-02-08 13:05:00.050337', updatedon = now(), updatedby = 'CDM-14945' 
where placementid = 'ed61afcc-271b-486a-abb3-2cde718c7bb8';