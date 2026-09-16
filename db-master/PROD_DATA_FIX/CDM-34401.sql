/*
 * CDM-34401 - Expungement Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Description - CW2293654:Please expungement this investigation. The Department does not have the closed record for this investigation. 
 * Assistant Deputy Director, Stephanie Cooke has approved this expungement request. 
 * expunge the case #CW2293654 as requested
 * 
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2293654'::character varying,
		null::date
	) ;
