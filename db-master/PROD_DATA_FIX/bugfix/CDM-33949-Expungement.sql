/*
 * CDM-33949 - Expungement Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Sub Component:Application
 * Description - CW2230514:Please expunge this investigation. The department does not have a closed record for this investigation. 
 * Assistant Deputy Director, Stephanie Cooke has approved this expungement request
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2230514'::character varying,
		null::date
	);
