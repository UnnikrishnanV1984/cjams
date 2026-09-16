/*
   Issue Description: CDM-15407
   Category/ Module  :  Case worker  
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE routing 
SET activeflag = 0, updatedby = 'CDM-15407', updatedon = now() 
WHERE routingid = '529e9b8f-78dd-49be-b9c9-9462d58ea2c0';