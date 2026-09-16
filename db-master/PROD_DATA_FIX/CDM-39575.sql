/*
 * CDM-39575 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - Dashboard:Please remove CIS # 030937408 program assignment from CJAMS investigation # CW2232122. 
 * Assistant Deputy Director, Stephanie Cooke has approved this request.
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2232122'::character varying,
		null::date
	);