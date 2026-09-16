
/*
   Issue Description: CDM-18456
   Category/ Module  : Removing pending record as the case
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-18456' where routingid = '422f72bb-1f31-4480-a50b-4da77aa41af0';