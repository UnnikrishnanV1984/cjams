/*
   Issue Description: CDM-30370
   Category/ Module  : Dashboard
   Root cause: User wants remove the pending approval form assign
   Pull request# for code fix: 8669
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update routing 
set activeflag = 0,
updatedby = 'CDM-30370', updatedon = now() 
where routingid ='8bdef72c-2ce7-4858-9aaa-f4cd23689a18' and activeflag = 1;
