/*
Issue Description: Please do a data fix to change the finding from Indicated to ruled out.
Category/Module: Support
Root cause: Requested closed records were not located, so finding needs to be changed
Fix provided: DB query to change findings record as ruled out
Data/Code fix ticket#:CDM-41361
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--updating record in tb_conv_inv_finding
update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2290775';