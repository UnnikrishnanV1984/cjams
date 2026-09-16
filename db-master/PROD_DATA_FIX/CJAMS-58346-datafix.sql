/*
Issue Description: CJAMS-58346 Finding Modification Request
Category/Module: GAP 
Root cause: User requested to modify the findings from Indicated neglect to Unsubstantiated neglect and expunge the case.
Fix provided: Data fix to update the findings from Indicated neglect to Unsubstantiated neglect and expunge the case.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where referral_id = 'CW2219999';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2219999'::character varying,
		null::date
	);