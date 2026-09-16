/*
Issue Description: Need data fix to end the child removal with 09/29/2022.
Category/Module: Support
Root cause: Child Removal can not be ended prior to the latest Service Log Actual End Date
Fix provided: DB query to end-date the open child removal 
Data/Code fix ticket#: CDM-43742
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakeservreqchildremoval
update intakeservreqchildremoval
set exitdate = '2022-09-29 00:00:00.000', returntransts = '2022-09-29', updatedby = 'CDM-43742', updatedon = now()
where intakeservreqchildremovalid = '6fa80640-a285-46a4-9487-5ee1dbaf762d' and activeflag = 1;

--Updating tb_client_eligibility
update tb_client_eligibility
set end_dt = '2022-09-29', update_user_id = 'CDM-43742', update_ts = now()
where eligibility_id = 10005876 and delete_sw = 'N';

--Updating personprogramarea
update personprogramarea
set enddate = '2022-09-29 00:00:00.000', updatedby = 'CDM-43742', updatedon = now()
where personprogramid = 'ff04b00c-70c9-45d9-b9ad-2440dddbf6a7' and activeflag = 1;