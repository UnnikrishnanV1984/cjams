/*
 * CDM-39088 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - CW2314058:Please remove CIS # 464015337 program assignment from CJAMS investigation # CW2314058. 
 * Assistant Deputy Director, Stephanie Cooke has approved this request. 
 * expunge case # CW2314058 as requested.
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2314058'::character varying,
		null::date
 	) ;
 	