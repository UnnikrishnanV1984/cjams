/*
   Issue Description: CJAMS-69266
   Category/ Module: Investigation finding
   Root cause: User requested to remove the duplicate investigation findings
   Fix Provided: As requested data fix has been provided by deleting the duplicate investigation findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   need to do data fix
*/


     
update investigationallegation
set activeflag=0, updatedby='CJAMS-69266', updatedon=now()
where investigationallegationid='9147938e-da09-46da-a967-61afe1bd60f5' and activeflag=1;   
    
update investigationallegation
set activeflag=0, updatedby='CJAMS-69266', updatedon=now()
where investigationallegationid='499e3ba3-0f72-42bd-bc3f-8d612fa3cb93' and activeflag=1;