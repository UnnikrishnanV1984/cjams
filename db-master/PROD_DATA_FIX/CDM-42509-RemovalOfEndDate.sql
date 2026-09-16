/*
Issue Description: Need data fix to remove the Removal End date for Renuka Andera Singh (CJAMS PID#:3277616).
Category/Module: Bug
Root cause: Child Removal end date needs to be deleted because of later appeal
Fix provided: DB queries to delete Child Removal end date
Data/Code fix ticket#: CDM-42509
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Removing end date from intakeservreqchildremoval
update intakeservreqchildremoval
set exitdate = null, returntransts = null, updatedby = 'CDM-42509', updatedon = now()
where intakeservreqchildremovalid = '8bc13b6d-0a57-478d-a182-7d4b49d355f5' and activeflag = 1;

--Removing end date from intakeservreqchildremoval_history
update intakeservreqchildremoval_history
set exitdate = null, returntransts = null, updatedby = 'CDM-42509', updatedon = now()
where intakeservreqchildremovalhistoryid = 'f90cdd20-9054-4e9a-be2c-d6bde2762bf1' and activeflag = 1;