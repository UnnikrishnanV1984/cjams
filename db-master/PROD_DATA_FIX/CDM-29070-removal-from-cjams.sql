-- CDM-29070
/*
-- Category/ Module: Removal from CJAMS
-- Root cause: Expunge the case
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2168698
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2168698'::character varying,
		null::date
	) ;
