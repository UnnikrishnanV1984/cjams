
/*
   Issue Description: CDM-17334
   Category/ Module  : Removing pending record
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-17334' where routingid = '1fc4180f-8364-4414-86e5-114456784db0';
