/*
Issue:Change in placement struture
Root Cause: Data fix is requested to remove Overdue reason button, In this case, the response timer date is stopped beyond the response timer due date
Fix Provided (Data Fix Only):Data fix is doneto remove Overdue reason button
Data/Code fix ticket#: CJAMS-65983
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update intakeservicerequest set reporteddate='2026-02-13 11:25:00', updatedby = 'CJAMS-65971',
updatedon = now() where intakeserviceid  = '7412ff2a-ec91-49ed-80dc-d6f7de2a13ef';


update cjams.cpsresponsetimeractions
    set activeflag = 0, 
        updatedby = 'CJAMS-65971',
        updatedon = now()
where intakeserviceid  = '7412ff2a-ec91-49ed-80dc-d6f7de2a13ef'    and activeflag = 1;