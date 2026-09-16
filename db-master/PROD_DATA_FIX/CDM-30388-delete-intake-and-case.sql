
/*
   Issue Description: CDM-30388
   Category/ Module  : Dashboard
   Root cause: User wants remove the pending approval form assign
   Pull request# for code fix: 8669
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30388'
where objectid in ('I231010474455');

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-30388',
    updatedon = now()
WHERE intakenumber in ('I231010474455');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-30388',
    updatedon = now()
WHERE intakenumber in ('I231010474455');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30388'
WHERE intakenumber in ('I231010474455');


update intakeservicerequest
set 
   activeflag = 0, 
   updatedby = 'CDM-30388',
   updatedon = now() 
where 
   servicerequestnumber = '231020404425';