/*
   Issue Description: CDM-33577
   Category/ Module  : Intake
   Root cause: User requested to remove duplicate referral 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-33577',
    updatedon = now()
WHERE intakenumber ='I231010929150';

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-33577',
    updatedon = now()
WHERE intakenumber ='I231010929150';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-33577'
WHERE intakenumber ='I231010929150';