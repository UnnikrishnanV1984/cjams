/*
  Issue Description:CJAMS-67313
Category/ Module:Application
Root cause: User requested to expunge the case and modify the maltreatment type as physical abuse
Fix provided: Data fix has been done to expunge the case 
Is code fix required: N 
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/


update tb_conv_inv_finding set investigation_finding_cd = 'Physical Abuse' where referral_id ='CW2220234';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2220234'::character varying,
		null::date
	);