/*
 * CDM-39089 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - CW2314287:Please remove CIS #464015337 program assignment from CJAMS Investigation CW2314287. 
 * Assistant Deputy Director, Stephanie Cooke has approved this request.
 * expunge case # CW2314287 as requested.
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2314287'::character varying,
		null::date
 	) ;