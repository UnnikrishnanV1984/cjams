/*
   Issue Description: CDM-35203
   Category/ Module  : Finding modification 
   Root cause: modify this Indicated Physical Abuse finding to Ruled Out Physical Abuse.
   Fix Provided: Updated investigation finding to Ruled out
*/

select * from tb_conv_inv_finding where referral_id ='CW2295550';

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2295550';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2295550'::character varying,
		null::date
	) ;