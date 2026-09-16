/*
   Issue Description: CDM-30981
   Category/ Module  : Case Plan 
   Root cause: user wants remove the records which are approved but shown as pending
   Pull request# for data fix: 7386
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/

update
    routing
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30981'
where
    routingid = 'a28cf4fb-c364-4ff6-b51b-224083b4bb85';





