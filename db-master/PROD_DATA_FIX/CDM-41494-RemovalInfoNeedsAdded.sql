/*
Issue Description: Environment at Removal and Removal End Time must be entered for purposes of Title-IVE determination.
Category/Module: Error
Root cause: CJAMS is not allowing information to be updated after approval
Fix provided: DB query to add environment and end time
Data/Code fix ticket#: CDM-41494
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakeservreqchildremoval
update intakeservreqchildremoval
set environmentatremovalkey = 'PAHOLD', returntime = '2022-12-15 11:00:00.000', updatedby = 'CDM-41494', updatedon = now()
where intakeservreqchildremovalid = '51328a06-6750-4e39-9c6b-ee54ace3603f' and activeflag = 1;