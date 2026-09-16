/*
   Issue Description: CDM-31688
   Category/ Module  : Prod data fix for Remove
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update routing set activeflag = 0, updatedby = 'CDM-31688', updatedon = now()
where routingid = '2189b92f-d8f2-452b-bab5-10e76f973dad' and activeflag = 1;