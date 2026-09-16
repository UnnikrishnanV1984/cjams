/*
Issue: CJAMS-63907 Removal in Draft
Category/Module: Child Removal
Root cause: Child removal was not done and stuck in draft state and is generating a Missed Visit report even though the case was closed.
            Data fix is needed to remove the draft child removal.
Fix provided:  Data fix has been done to delete the child removal that is in draft state for the case 251030536336
Data/Code fix ticket#: CJAMS-63907
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is draft removal and data fix should resolve it.
*/

update intakeservreqchildremoval
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-63907'
where intakeservreqchildremovalid = '0accbe1c-ae4d-42ef-a310-1f47df99d009'
and activeflag=1;

update intakeservreqchildremoval_history
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-63907'
where intakeservreqchildremovalid = '0accbe1c-ae4d-42ef-a310-1f47df99d009'
and activeflag=1;


