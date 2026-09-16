/* 
   Issue Description: CJAMS-66139
   Category/ Module  : Expungement Request
   Root cause: Data fix for expunging the case and updated the cps findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   void the rejected provider placement from backend
*/

update tb_conv_inv_finding set investigation_finding_cd = 'Unsubstantiated' where referral_id ='CW2000532';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2000532'::character varying,
		null::date
	);

    