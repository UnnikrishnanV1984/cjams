/*
   Issue Description: CDM-25896
   Category/ Module  : approval inbox
   Root cause: user wants to remove the approved record which shows still pending
   Pull request# for code fix: 6618
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed. Need to do data fix
*/
update routing set activeflag = 0, updatedby = 'CDM-25896', updatedon = now()
where routingid = 'db91576b-0f8c-408a-ab56-2775ada598ff';