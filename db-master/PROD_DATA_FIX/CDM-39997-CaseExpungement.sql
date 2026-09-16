/*
Issue Description: CW2181800 for Nicholas Thomas needs to be expunged please.
Category/ Module : Expungement
Root cause: Investigation finding needs to be changed to ruled out before case expungement
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-39997
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updaring tb_conv_inv_finding from indicated to ruled out
update tb_conv_inv_finding
set
	investigation_finding_cd = 'Ruled Out',
	etl_userid = 'CDM-39997',
	etl_load_date = now()
where referral_id = 'CW2181800';

--Expunging the case
select vl_sqlcode, vs_err_message from cjams.expungcaserequest ('IR'::character varying, 'CW2181800'::character varying, null::date);