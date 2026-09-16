/*
 * CDM-39087 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - CW2297822:Please remove CIS # 464015337 program assignment from CJAMS investigation # CW2297822. 
 * Assistant Deputy Director, Stephanie Cooke has approved this request. 
 * expunge the case # CW2297822 as requested.
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2297822'::character varying,
		null::date
 	) ;
 	