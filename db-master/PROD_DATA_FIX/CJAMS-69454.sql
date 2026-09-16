/*
Issue Description: CJAMS-69454 - PP
Category/Module: Permanency Plan
Root cause: The Guardianship by Non-Relative permanency plan on case # 3258823 was submitted for review with an incorrect plan end date and the supervisor rejected the review request, so the Plan End Date is displayed on the permanency plan list and the Plan Review Status remains Rejected.
Fix provided: Data fix has been promoted to remove the Plan End Date and update the Plan Review Status to Approved for the Guardianship by Non-Relative permanency plan on case # 3258823.
Data/Code fix ticket#: CJAMS-69454
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue is specific to data entered by the user and is not a logical issue.
*/

update permanencyplan
set enddate = NULL,
    updatedby = 'CJAMS-69454',
    updatedon = now()
where permanencyplanid = '598282d7-3fe6-477d-a74b-99db7dfd4789'
and activeflag = 1;

update routing
set routingstatustypeid = 16,
    routeddescription = 'Permanency Plan Approved',
    updatedby = 'CJAMS-69454',
    updatedon = now()
where routingid = 'a201255b-3b45-48e2-8abf-e955372a718e'
and eventcode = 'PPLR'
and activeflag = 1;

update permanencyplanhistory
set status = 'Approved',
    enddate = NULL,
    updatedby = 'CJAMS-69454',
    updatedon = now()
where permanencyplanhistoryid = 'a150633c-2d74-456d-81d9-206bf11b1195';
