/*
Issue: Please do a data fix to expunge the case as requested
Category/Module: Support
Root cause: Case expungement as part of data cleanup
Fix provided: DB query to expunge the case
Data/Code fix ticket#: CDM-44167
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Reason why no related code fix: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation. CJAMS is not expunging such CIS converted investigations with automated batch. 
So, we are expunging these CIS Investigations with SSA approvals.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out', etl_userid = 'CDM-44167' , etl_load_date = now()
where inv_finding_id=205075 and referral_id='CW2229134';

--expunging case
select vl_sqlcode, vs_err_message from 
cjams.expungcaserequest('IR'::character varying, 'CW2229134'::character varying, null::date);