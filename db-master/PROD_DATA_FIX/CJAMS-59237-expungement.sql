/*
Issue Description: CJAMS-59237 CW2222098:Please modify this indicated finding to ruled out and expunge from the system.
Category/Module: Expungement 
Root cause: User requested to modify the findings from Indicated to Ruled out and expunge the case.
Fix provided: Data fix to update the findings from Indicated to Ruled out and expunge the case.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2222098';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2222098'::character varying,
		null::date
	);