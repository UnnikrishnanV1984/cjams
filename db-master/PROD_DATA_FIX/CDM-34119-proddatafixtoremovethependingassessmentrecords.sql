/*
   Issue Description: CDM-34119
   Category/ Module  : Prod data fix to remove the pending assignment
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




update routing set activeflag = 0, updatedby = 'CDM-34119', updatedon = now()
where routingid = 'e1c16916-616a-4b27-bde3-736c140b1410' and activeflag = 1;
 