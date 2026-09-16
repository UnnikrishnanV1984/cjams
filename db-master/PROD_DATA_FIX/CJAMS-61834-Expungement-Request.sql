/*
 * CJAMS-61834 - Expungement Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Cases: CW2292327,CW2290338
*/

--CW2292327 
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2292327'::character varying,
		null::date
	) ;
	

--CW2290338
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2290338'::character varying,
		null::date
	) ;