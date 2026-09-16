/*
   Issue Description: CDM-25040
   Category/ Module  : Case Plan 
   Root cause: user wants remove the records which are approved but shown as pending
   Pull request# for data fix: 7386
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/

update routing 
set activeflag = 0,
updatedon = now(),
 updatedby = 'CDM-25040'  
 where routingid IN ('09f49ce0-1b1d-4663-8ae0-5c0dfce69c13', '281fd9c0-76ac-49b0-b7ed-1bd37a1db61e','f5906d0a-291c-4c63-88fc-d5a69a2a4e95');