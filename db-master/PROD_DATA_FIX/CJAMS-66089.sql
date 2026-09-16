/*
Issue: CJAMS-66089 Defect: LJ Measure 24
Category/Module: Child Removal
Root cause: Data fix is needed to remove the draft child removal.
Fix provided:  Data fix has been done to delete the child removal that is in draft state 
Data/Code fix ticket#: CJAMS-66089
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is draft removal and data fix should resolve it.
*/

update intakeservreqchildremoval
set
    activeflag=0,
    updatedby = 'CJAMS-66089',
    updatedon = now()
where intakeservreqchildremovalid = '4b0ccb46-167f-4dfa-b784-8d0af821e31d' and activeflag =1;

update intakeservreqchildremoval_history
set
    activeflag=0,
    updatedby = 'CJAMS-66089',
    updatedon = now()
where intakeservreqchildremovalid = '4b0ccb46-167f-4dfa-b784-8d0af821e31d' and activeflag =1;

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-66089'
where objectid = '4b0ccb46-167f-4dfa-b784-8d0af821e31d'
and activeflag=1;