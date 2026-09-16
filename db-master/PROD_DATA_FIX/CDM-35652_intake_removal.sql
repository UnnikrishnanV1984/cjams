/*
   Issue Description: CDM-35652
   Category/ Module  : Decision
   Root cause: User wants to remove delete Intake # I231010626293
   Resolution: Removed the intake # I231010626293 as requeste by setting activeflag to 0.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35652'
where intakenumber = 'I231010626293' and activeflag=1;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35652'
where intakenumber = 'I231010626293' and activeflag=1;

update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35652'
where intakenumber = 'I231010626293' and activeflag=1;

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35652'
where servicerequestnumber='231021434736' and activeflag=1;