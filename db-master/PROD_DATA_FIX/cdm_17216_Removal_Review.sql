/*
   Issue Description: CDM-17216
   Category/ Module  :  Removal Review
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-17216' where routingid = '422f72bb-1f31-4480-a50b-4da77aa41af0';