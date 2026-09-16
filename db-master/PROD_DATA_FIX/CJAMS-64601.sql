

/*
Issue Description: Expungement
Category/Module: Expungement 
Root cause: User requested to expunge the case.
Fix provided: Data fix done to expunge the case.
Data/Code fix ticket#: CJAMS-64601
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'221020259927'::character varying,
		null::date
	);