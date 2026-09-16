/*
 * CDM-39530 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - Dashboard:remove CIS # 30879746 program assignment from CJAMS investigation # 
 * CW2286659. The Department does not have the closed record for this investigation. 
 * Assistant Deputy Director, Stephanie Cooke has approved this request. 
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2286659'::character varying,
		null::date
	) ;
    