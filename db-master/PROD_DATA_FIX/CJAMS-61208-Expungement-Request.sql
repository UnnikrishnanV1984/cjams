/*
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: Expunge the case
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
-- CPS IR: CW2215068
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2215068'::character varying,
		null::date
	) ;

-- CPS IR: CW2240613
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2240613'::character varying,
		null::date
	) ;
