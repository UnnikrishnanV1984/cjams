/*
   Issue Description: CDM-29904
   Category/ Module  : inatke delete
   Root cause: user wants to delete intake as it was created in error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

UPDATE routing
SET activeflag = 0, updatedby = 'CDM-29904 ', updatedon = now()
WHERE routingid = '704fbf24-8034-4fab-83e5-7a754f89d71c';

update intakedastaging  
    set status = 'Closed' , updatedby = 'CDM-29904', updatedon = now()
    where intakenumber = 'I221010227575'
    and activeflag = 1;