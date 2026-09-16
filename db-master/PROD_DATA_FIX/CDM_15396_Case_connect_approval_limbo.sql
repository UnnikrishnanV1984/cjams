/*
   Issue Description: CDM-15396
   Category/ Module  :  Case connect  
   Root cause: user requeseted to remove it as it is still showing under approval even it is closed
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE routing 
SET activeflag = 0, updatedby = 'CDM-15396', updatedon = now() 
WHERE routingid = '869db024-80ce-4e8a-843d-e67d864dd163';