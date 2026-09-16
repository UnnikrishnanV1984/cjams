/*
Issue: CJAMS-63929 Removal accidentally started for the wrong child
Category/Module: Child Removal
Root cause: Child removal was accidentally started for wrong child and stuck in draft state and is generating a Missed Visit report even though the case was closed.
            Data fix is needed to remove the draft child removal.
            CASE ID: 3213215
            CJAMS PID: 4481197
            Client: Zya Ray Winter Snow
Fix provided:  Data fix has been done to delete the child removal that is in draft state for the case 3213215
Data/Code fix ticket#: CJAMS-63929
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is draft removal and data fix should resolve it.
*/

update intakeservreqchildremoval
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-63929'
where intakeservreqchildremovalid = '98fab146-8f30-4d02-990c-895d1d9375ff'
and activeflag=1;

update intakeservreqchildremoval_history
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-63929'
where intakeservreqchildremovalid = '98fab146-8f30-4d02-990c-895d1d9375ff'
and activeflag=1;