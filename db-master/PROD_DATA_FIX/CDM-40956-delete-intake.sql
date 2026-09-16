/*
   Issue Description: CDM-40956
   Category/ Module  : Prod data fix to remove  intake
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-40956'
where objectid in ('I221010301966');

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-40956',
    updatedon = now()
WHERE intakenumber in ('I221010301966');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-40956',
    updatedon = now()
WHERE intakenumber in ('I221010301966');

