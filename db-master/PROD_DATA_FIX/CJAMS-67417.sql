
/*
Issue Description: Expungement Request
Category/Module: Expungement 
Root cause: User requested to expunge the case.
Fix provided: Data fix done to expunge the case.
Data/Code fix ticket#: CJAMS-67417
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2255084'::character varying,
		null::date
	);