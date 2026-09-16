
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
    updatedby = 'CDM-32114'
where objectid in ('I231010376154');

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-32114',
    updatedon = now()
WHERE intakenumber in ('I231010376154');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-32114',
    updatedon = now()
WHERE intakenumber in ('I231010376154');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-32114'
WHERE intakenumber in ('I231010376154');

update intakeservicerequest set servicecaseid = NULL,updatedby = 'CDM-32114',updatedon =now() where intakeserviceid ='c87bd433-c1fa-4dfa-ac58-26b67f12f692';
