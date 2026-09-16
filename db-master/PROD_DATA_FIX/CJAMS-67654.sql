

/*
Issue Description: Expungement Request
Category/Module: Expungement 
Root cause: User requested to expunge the CPS IR # CW2250290 and CW2250289.
Fix provided: Data fix done to expunge the cases CW2250290 and CW2250289.
Data/Code fix ticket#: CJAMS-67654
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Fix
*/
SELECT vl_sqlcode, vs_err_message
FROM cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2250290'::character varying,
		null::date
	) ;

SELECT vl_sqlcode, vs_err_message
FROM cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2250289'::character varying,
		null::date
	) ;