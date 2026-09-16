/*
Issue Description: CJAMS-59688 W2182002:This investigation was Administratively reviewed following request from Ms. Chrystle Norris following 
				   a CPS background clearance. Per admin review, the finding should be modified to unsubstantiated and she should no longer be linked to the case as alleged maltreator/finding due to 5 year expungement
Category/Module: Expungement 
Root cause: User requested to modify the findings from Indicated neglect to Unsubstantiated neglect and expunge the case.
Fix provided: Data fix to update the findings from Indicated neglect to Unsubstantiated neglect and expunge the case.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where referral_id = 'CW2182002';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2182002'::character varying,
		null::date
	);