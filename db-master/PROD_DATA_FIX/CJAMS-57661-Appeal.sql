/*
Issue Description: Please carry out data fix to
Need appeal rights to older 98 case who is appealing and finding needs to be changed.
Category/Module: Bug
Root cause: Old migration case needs investigation finding changed
Fix provided: DB queries to update the investigation finding.
Data/Code fix ticket#: CJAMS-57661
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Old case issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where inv_finding_id = 99749 and referral_id = 'CW2096248';