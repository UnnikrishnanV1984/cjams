/*
  Issue Description:CJAMS-68541
Category/ Module:Application
Root cause: User requested to expunge the case and modify the maltreatment type as Unsubstantiated Neglect
Fix provided: Data fix has been done to expunge the case and changed the maltreatment type as requested
Is code fix required: N 
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/

update tb_conv_inv_finding set investigation_finding_cd = 'Unsubstantiated' where referral_id ='CW2227346';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2227346'::character varying,
		null::date
	);