/*
   Issue Description: CDM-25823
   Category/ Module  : approval inbox
   Root cause: user wants to remove the record which shows pending
   Pull request# for code fix: 6602
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed. Need to do data fix
*/
update routing 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-25823' 
where routingid = '728703da-d812-4955-b7d6-38dfd8f34be8';