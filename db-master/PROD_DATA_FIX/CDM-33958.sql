/*
 * CDM-33958 - Expungement Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Description - CW2210428:Please expunge this investigation. The Department does not have the closed record for this investigation. 
 * Assistant Deputy Director, Stephanie Cooke has approved this expungement request.
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2210428'::character varying,
		null::date
	);