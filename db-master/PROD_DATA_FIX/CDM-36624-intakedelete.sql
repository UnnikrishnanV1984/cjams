/*
   Issue Description: CDM-36624
   Category/ Module  : Intake
   Root cause: User requested to remove duplicate referral 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-36624',
    updatedon = now()
WHERE intakenumber ='I241011940932';

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-36624',
    updatedon = now()
WHERE intakenumber ='I241011940932';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36624'
WHERE intakenumber ='I241011940932';