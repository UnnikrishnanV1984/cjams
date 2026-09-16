/*
  Issue Description:CDM-39573
Category/ Module:Application
Root cause: User requested to expunge the case
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/


update tb_conv_inv_finding set investigation_finding_cd = 'Ruled Out' where referral_id ='CW2269783';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2269783'::character varying,
		null::date
	);