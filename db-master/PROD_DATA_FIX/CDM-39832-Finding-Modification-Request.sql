/*
Issue Description: Please modify this indicated finding to ruled out. Documentation supporting this request has been uploaded to the Document tab.
Category/ Module : Bug
Root cause: Chnage ndicated  to Ruled Out.
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-39832
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update tb_conv_inv_finding
set
	investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2257457';