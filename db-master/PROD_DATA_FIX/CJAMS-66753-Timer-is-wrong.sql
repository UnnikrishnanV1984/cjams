/*
Issue Description:
Category/Module: Bug
Root cause: Proceeding with datafix to modify the start date as 03/30/2026 3:11 PM
Fix provided:DB query to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-65573
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

 update intakeservicerequest
set reporteddate = '2026-03-30 15:11:00',
    updatedby = 'CJAMS-65573',
    updatedon = now()
where servicerequestnumber = '261023721153' and activeflag =1;


