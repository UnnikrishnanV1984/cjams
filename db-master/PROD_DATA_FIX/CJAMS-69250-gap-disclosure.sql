/*
Issue Description: CJAMS-69250 - Unable to submit for disclosure checklist for approval
Category/Module: Permanency Plan / GAP disclosure
Root cause: User is not able to submit for approval as there is a rejected record for the disclosure checklist.
Fix provided: Data fix has been promoted to submit for approval as by deleting the rejected record from the disclosure checklist.
Data/Code fix ticket#: CJAMS-69250
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User data entry error, no defect in the application.
*/

update gapdisclosure
set activeflag=0, updatedby='CJAMS-69250', updatedon=now()
where gapdisclosureid='6ac06bac-3431-4f82-bb46-60b61fd72407' and activeflag=1;

update routing
set activeflag=0, 
    updatedby='CJAMS-69250', 
    updatedon=now()
where eventcode = 'GADR'
and objectid ='6ac06bac-3431-4f82-bb46-60b61fd72407'
and activeflag=1;