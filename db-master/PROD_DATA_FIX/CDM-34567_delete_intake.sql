/*
   Issue Description: CDM-34567
   Category/ Module  : Prod data fix to remove intake
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34567'
where objectid in ('I231011269826');

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-34567',
    updatedon = now()
WHERE intakenumber in ('I231011269826');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-34567',
    updatedon = now()
WHERE intakenumber in ('I231011269826');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34567'
WHERE intakenumber in ('I231011269826');