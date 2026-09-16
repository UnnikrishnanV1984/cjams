/*
   Issue Description: CDM-31375
   Category/ Module  : Prod data fix to remove duplicate intake
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-31375'
where objectid in ('I231010604790');

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-31375',
    updatedon = now()
WHERE intakenumber in ('I231010604790');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-31375',
    updatedon = now()
WHERE intakenumber in ('I231010604790');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-31375'
WHERE intakenumber in ('I231010604790');