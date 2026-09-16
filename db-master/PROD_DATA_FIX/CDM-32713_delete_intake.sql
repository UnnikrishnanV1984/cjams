/*
   Issue Description: CDM-32713
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
    updatedby = 'CDM-32713'
where objectid in ('I202000557143');

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-32713',
    updatedon = now()
WHERE intakenumber in ('I202000557143');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-32713',
    updatedon = now()
WHERE intakenumber in ('I202000557143');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-32713'
WHERE intakenumber in ('I202000557143');