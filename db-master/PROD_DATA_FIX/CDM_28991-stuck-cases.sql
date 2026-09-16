/*
   Issue Description: CDM-28991
   Category/ Module  : Stuck Cases
   Root cause: The stuck cases needs to be removed
   Reason why no related code fix:  Data fix
   
*/

UPDATE
    intakesnapshot
SET
    updatedby = 'CDM-28991',
    updatedon = now(),
    activeflag = 0
WHERE
    intakenumber in ('I211010218320', 'I221010308160');

update
    intakeservicerequest
set
    activeflag = 0,
    updatedby = 'CDM-28991',
    updatedon = now()
where
    intakenumber in ('I211010218320', 'I221010308160');

update
    intakedastaging
set
    activeflag = 0,
    updatedby = 'CDM-28991',
    updatedon = now()
where
    intakenumber in ('I211010218320', 'I221010308160');

update
    intakedastatus
set
    activeflag = 0,
    updatedby = 'CDM-28991',
    updatedon = now()
where
    intakenumber in ('I211010218320', 'I221010308160');

update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-28991',
    updatedon = now()
where
    objectid in ('I211010218320', 'I221010308160');

update
    intakeservicerequestactor
set
    activeflag = 0,
    updatedby = 'CDM-28991',
    updatedon = now()
where
    intakenumber in ('I211010218320', 'I221010308160');