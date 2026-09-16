

/*
Issue Description: Expungement Request
Category/Module: Expungement 
Root cause: User requested to expunge the CPS IR # CW2215724.
Fix provided: Data fix done to expunge the case CW2215724.
Data/Code fix ticket#: CJAMS-67657
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/
SELECT vl_sqlcode, vs_err_message
FROM cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2215724'::character varying,
		null::date
	) ;