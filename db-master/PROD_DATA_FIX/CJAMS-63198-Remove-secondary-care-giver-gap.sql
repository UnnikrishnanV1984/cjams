/*
Issue: CJAMS-63198 Need to removed second caregiver from GAP application
Category/Module: GAP
Root cause: 221030018879:The second caregiver in this case is incorrect and does not reflect the court order or physical application. 
            Data fix needed to remove the secondary care giver name.
Fix provided: Data fix has been done  to remove the secondary guardian name (SEAN SHIFLETT) in the Guardian Information section.
Data/Code fix ticket#: CJAMS-63198
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: GAP agreement is already approved and data fix is sufficient to fix this issue.
*/

update guardianship
set guardiantwoname = null,
	updatedon = now(),
	updatedby = 'CJAMS-63198'
where gapid in ('1f1047c7-88c5-4fe2-9c76-3025f56a3009','a58abfb5-7185-4e73-8d27-80585da565b0')
and activeflag=1;