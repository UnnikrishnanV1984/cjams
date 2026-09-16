/*
 * CDM-35244 - Expungement Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Case CW2243573
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2243573'::character varying,
		null::date
	) ;