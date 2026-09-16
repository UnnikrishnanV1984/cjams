/*
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: Expunge the case
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2292935
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2292935'::character varying,
		null::date
	) ;	

-- CPS IR: CW2292934
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2292934'::character varying,
		null::date
	) ;