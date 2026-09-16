/*
Issue Description: Please carry out data fix
1. Remove the Child Removal
2. Remove OOH program assignment end-date (09/18/2024)
Category/Module: Support
Root cause: Void placements can't be deleted or edited due to impact on Finance
Fix provided: DB queries to remove child removal and program assignment end dates so the user can create a new placement
Data/Code fix ticket#: CDM-43795
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakeservreqchildremoval
update intakeservreqchildremoval
set exitdate = null, returntransts = null, updatedby = 'CDM-43795', updatedon = now()
where intakeservreqchildremovalid = '90620180-5cb8-4ee0-aef9-bba8aac8fd87' and activeflag = 1;

--Updating intakeservreqchildremovalhistory
update intakeservreqchildremoval_history
set exitdate = null, returntransts = null, updatedby = 'CDM-43795', updatedon = now()
where intakeservreqchildremovalhistoryid = 'eda22b5d-69da-459f-bb88-14771e7814d2' and activeflag = 1;

--Updating personprogramarea
update personprogramarea
set enddate = null, updatedby = 'CDM-43795', updatedon = now()
where personprogramid = '0249c43e-8948-4b91-944c-ff936c71cd11' and activeflag = 1;

--Updating tb_client_eligibility
update tb_client_eligibility
set end_dt = null, update_user_id = 'CDM-43795', update_ts = now()
where eligibility_id = '10030074' and delete_sw = 'N';