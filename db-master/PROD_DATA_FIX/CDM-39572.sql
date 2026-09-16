/*
 * CDM-39572 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - Dashboard:Please remove CIS # 413023610 program assignment from CJAMS investigation # CW2288212. 
 * The Department does not have the closed record for the investigation. 
 * Assistant Deputy Director, Stephanie Cooke has approved this request.
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2288212'::character varying,
		null::date
	);