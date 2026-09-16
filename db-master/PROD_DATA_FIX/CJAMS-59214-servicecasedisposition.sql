/*
Issue Description: 3263423:intake was initially associated with the wrong service case. Issue was resolved and case was attached to the right service case, but shows a re-open date of 4/21/25. Case needs to be re-opened as of 3/27/25
Category/Module: Bug
Root cause: due to data glitch caused user can only create Intake with service case, but they do not have access to update or edit record.
Fix provided:DB queries to update record in servicecasedisposition table.
Data/Code fix ticket#: CJAMS-59214
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update servicecasedisposition
set activeflag =0, updatedby = 'CJAMS-59214', updatedon = now()
where servicecasedispositionid = '536c5ad5-eee3-4003-836e-b5af87957d5c' and activeflag =1;