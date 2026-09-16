
/*
   Issue Description: CDM-33014
   Category/ Module  :  Intake
   Root cause: user asked to delete the pending intake and remove the case connect
    Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-33014'
where objectid in ('I231010795666');

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-33014',
    updatedon = now()
WHERE intakenumber in ('I231010795666');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-33014',
    updatedon = now()
WHERE intakenumber in ('I231010795666');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-33014'
WHERE intakenumber in ('I231010795666');
