
/*
   Issue Description: CDM-29986
   Category/ Module  :  Intake
   Root cause: user asked to delete the Intake I221010231414 as this intake is pending
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29986'
where objectid = 'I221010231414';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29986'
where intakenumber = 'I221010231414';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29986'
where intakenumber = 'I221010231414';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29986'
where intakenumber = 'I221010231414';

update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29986'
    where intakeserviceid = 'c63d9be7-7a3a-44db-a30f-228131183a20';