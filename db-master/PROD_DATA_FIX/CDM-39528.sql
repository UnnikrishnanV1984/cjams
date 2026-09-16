/*
 * CDM-39528 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - Dashboard: remove CIS # 494010185 program assignment from CJAMS Investigation # CW2284330. 
 * the Department does not have the closed record for this investigation. Assistant Deputy Director, 
 * Stephanie Cooke has approved this request. 
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2284330'::character varying,
		null::date
	) ;
	