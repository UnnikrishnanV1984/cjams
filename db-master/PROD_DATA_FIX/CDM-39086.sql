/*
 * CDM-39086 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - CW2297821:Please remove CIS # 464015337 program assignment from CJAMS investigation # CW2297821. 
 * Assistant Deputy Director, Stephanie Cooke has approved this request.
 * expunge case # CW2297821 as requested.
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2297821'::character varying,
		null::date
 	) ;
     