
/*
Issue Description: Expunge Old Case
Category/Module: Expungement 
Root cause: User requested to modify the findings from Indicated to set investigation_finding_cd = 'Unsubstantiated'
 and expunge the case.
Fix provided: Data fix to update the findings from Indicated to Unsubstantiated and expunge the case.
Data/Code fix ticket#: CJAMS-64368
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/
update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where referral_id = 'CW2000532';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2000532'::character varying,
		null::date
	);