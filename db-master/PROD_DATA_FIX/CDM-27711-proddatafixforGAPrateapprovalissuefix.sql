/*
   Issue Description: CDM-27711
   Category/ Module  : Prod data fix to the Gap Rate approval issue
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update routing set fromsecurityusersid = 'a8c288b0-d70f-4ef3-8ed8-2477beb2746c', tosecurityusersid = 'd4edc3f7-7cf6-43f9-b080-f32f03625d97', updatedon = now() , 
updatedby = 'CDM-27711'
where routingid in ('053cd6ca-7f2e-4485-b62a-4edb657a0e5c') and activeflag = 1;
