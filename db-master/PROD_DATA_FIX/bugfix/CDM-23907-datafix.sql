/*
   Issue Description: CDM-23907 service log
   Category/ Module  : service log
   Root cause: DOcument is not shown in service log. 

   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Data fix: Updating the authorization code
*/


UPDATE documentproperties 
SET updatedby = 'CDM-23907', updatedon = now(), 
additionalobjectid = 1846928
WHERE 
documentpropertiesid = 'a4166490-9cfe-4dbf-b320-ff1e3a21c46f';


