/*
 * CDM-32878 - Expungement Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Sub Component:Application
 * Description - CW2284990:Please expunge this investigation. The department does not have the closed record for this investigation. 
 * Assistant Deputy Director, Stephanie Cooke has approved this request.
 * 
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2284990'::character varying,
		null::date
	);	