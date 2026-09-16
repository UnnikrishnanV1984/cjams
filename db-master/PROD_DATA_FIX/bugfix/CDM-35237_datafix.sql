/*
   Issue Description: CDM-35237
   Category/ Module  : Finding modification requests
   Root cause: Duplicate maltreat records inserted on same time 
   Fix Provided: Updated the investigation_finding to Unsubstantiated
*/

select * from tb_conv_inv_finding where referral_id = 'CW2265695';

update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where referral_id = 'CW2265695';


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2265695'::character varying,
		null::date
	) ;