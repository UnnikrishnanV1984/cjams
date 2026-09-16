/*
Issue Description: 
Category/Module: Expungement 
Root cause: User requested to expunge the case.
Fix provided: Data fix to update the findings from Indicated to expunge the case.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'221020177798'::character varying,
		null::date
	) ;