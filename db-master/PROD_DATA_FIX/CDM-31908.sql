/*
 * CDM-31908 - Expungement
 * Customer Email ID:joann.gochnour@maryland.gov
 * Customer Name:Joann Gochnour
 * Focus Area:Decision
 * Description - CW2145387:Following an administrative review after an employment background clearance, 
 * CW2145387 would have been handled as an AR by today's standards. 
 * The Indicated Abuse finding can be expunged.
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2145387'::character varying,
		null::date
	) ;
