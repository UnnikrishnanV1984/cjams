/*
Issue Description: CJAMS-61729 data fix has been done to expunge the CPS-IR case (221020259721) 
Category/Module: Expungement 
Root cause: User requested to expunge the CPS-IR case (221020259721).
Fix provided: Data fix to expunge the CPS-IR case (221020259721).
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'221020259721'::character varying,
		null::date
	) ;