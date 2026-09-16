/*
Issue Description: Please proceed with the data fix to modify the finding from indicated neglect to Ruled Out neglect and expunge the CPS IR case
Category/Module: Support
Root cause: Finding change to rule out and case expungement as part of data cleanup
Fix provided: DB queries to change investigation finding to ruled out and expunge the case
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Expungement request
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--select * from tb_conv_inv_finding where referral_id = 'CW2232947';--208888
-- Ruled Out tb_conv_inv_finding
update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where inv_finding_id = '208888';

--expunging case
select vl_sqlcode, vs_err_message from cjams.expungcaserequest('IR'::character varying, 'CW2232947'::character varying, null::date);