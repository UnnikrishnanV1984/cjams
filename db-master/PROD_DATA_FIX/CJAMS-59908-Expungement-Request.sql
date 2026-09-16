/*
-- Category/ Module: expunge record from CJAMS
-- Root cause: Expunge the case
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2155287'::character varying,
		null::date
	) ;