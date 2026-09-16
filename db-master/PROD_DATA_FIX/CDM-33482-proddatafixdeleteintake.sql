
/*
   Issue Description: CDM-33261
   Category/ Module  : Updating gap Start date and end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/





/*
   Issue Description: CDM-32114
   Category/ Module  :  Intake
   Root cause: user asked to delete the pending intake and remove the case connect
    Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-33482'
where objectid in ('I231010913480');

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-33482',
    updatedon = now()
WHERE intakenumber in ('I231010913480');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-33482',
    updatedon = now()
WHERE intakenumber in ('I231010913480');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-33482'
WHERE intakenumber in ('I231010913480');
