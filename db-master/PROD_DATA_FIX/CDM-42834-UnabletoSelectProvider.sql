/*
Issue: Please provide the data fix to remove the child removal end date and the corresponding OOH Program assignment.
Category/Module: Error
Root cause: Program assignment and child removal were end dated before placement
Fix provided: DB queries to remove end date from program assignment and child removal
Data/Code fix ticket#: CDM-42834
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Nullifying end date in personprogramarea
update personprogramarea
set enddate = null, updatedby = 'CDM-42834', updatedon = now()
where personprogramid = 'a59cb833-3954-4aa0-81bc-d645cbada1f2' and activeflag = 1;

--Nullifying end date in intakeserreqchildremoval
update intakeservreqchildremoval
set exitdate = null, returntransts = null, updatedby = 'CDM-42834', updatedon = now()
where intakeservreqchildremovalid = '396ba383-cea1-4733-82e9-96969108d764' and activeflag = 1;

--Nullifying end date in intakeserreqchildremoval_history
update intakeservreqchildremoval_history
set exitdate = null, updatedby = 'CDM-42834', updatedon = now()
where  intakeservreqchildremovalid = '396ba383-cea1-4733-82e9-96969108d764' and activeflag = 1;

--Nullifying end date in tb_client_eligibility
update tb_client_eligibility
set end_dt = null, update_user_id = 'CDM-42834', update_ts = now()
where client_id = 4472196;