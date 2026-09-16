/*
   Issue Description: CDM-40026
   Category/ Module  :  Investigation findings
   Root cause: user wants to expunge the case and modify the findings to ruled out 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update tb_conv_inv_finding set investigation_finding_cd = 'Ruled Out' where referral_id ='CW2022929';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2022929'::character varying,
		null::date
	);