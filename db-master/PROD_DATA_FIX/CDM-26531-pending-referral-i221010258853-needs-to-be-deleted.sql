
/*
   Issue Description: CDM-26531
   Category/ Module  :  Intake
   Root cause: user asked to delete the Intake I221010258853 as this intake is pending
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26531'
where objectid = 'I221010258853';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26531'
where intakenumber = 'I221010258853';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26531'
where intakenumber = 'I221010258853';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26531'
where intakenumber = 'I221010258853';