/*
 * CDM-33321 - Expungement Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Sub Component:Application
 * Description - CW2274116:Please expunge this investigation. The Department does not have the closed record for this investigation. 
 * Assistant Deputy Director, Stephanie Cooke has approved this expungement request 
 * 
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2274116'::character varying,
		null::date
	);	