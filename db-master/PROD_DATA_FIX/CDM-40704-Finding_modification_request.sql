/*
   Issue Description: CDM-40704
   Category/ Module  : Finding modification requests
   Root cause: 
   Fix Provided: Updated the investigation_finding to Ruled Out.
*/



update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2295409' and inv_finding_id=271350;


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2295409'::character varying,
		null::date
	) ;