/*

Issue Description: CDM-44175
   Category/ Module  : Data fix for expunge request.
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

 update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2281186' and inv_finding_id=257127;

 select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2281186'::character varying,
		null::date
 	) ;