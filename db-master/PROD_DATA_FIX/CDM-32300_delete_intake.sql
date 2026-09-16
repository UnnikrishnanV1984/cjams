/*
   Issue Description: CDM-32300
   Category/ Module  : Prod data fix to remove incomplete intakes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-32300',
    updatedon = now()
WHERE intakenumber in ('I221010270588', 'I221010233719');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-32300',
    updatedon = now()
WHERE intakenumber in ('I221010270588', 'I221010233719');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-32300'
WHERE intakenumber in ('I221010270588', 'I221010233719');