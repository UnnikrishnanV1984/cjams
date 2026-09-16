-- CDM-28788
/*
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: Expunge the case
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2254448
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2254448'::character varying,
		null::date
	) ;
