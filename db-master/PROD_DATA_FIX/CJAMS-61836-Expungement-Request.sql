/*
 * CJAMS-61836 - Expungement Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Case CW2272823
*/
--CW2272823
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2272823'::character varying,
		null::date
	) ;