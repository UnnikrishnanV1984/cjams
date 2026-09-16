/*
Issue Description: Please modify the finding to Ruled Out and immediately expunge.
Category/Module: Expungement, Finding-Modification
Root cause: Investigation finding needs to be changed to ruled out before case expungement
Fix provided: Db query to change the investigation finding and expunge the case
Code fix ticket#: CDM-40599
Reason why no related code fix: CJAMS is not expunging such CIS converted investigations with automated batch. 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating tb_conv_inv_finding from indicated to ruled out
update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out', etl_userid = 'CDM-40599', etl_load_date = now()
where referral_id = 'CW2234740';

--Expunging the case
select vl_sqlcode, vs_err_message from cjams.expungcaserequest ('IR'::character varying, 'CW2234740'::character varying, null::date);