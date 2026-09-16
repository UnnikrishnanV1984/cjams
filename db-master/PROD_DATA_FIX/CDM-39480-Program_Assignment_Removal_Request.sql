/*
 * CDM-39840 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description -Please remove CIS # 030535060 program assignment from CJAMS investigation CW2293998.
     The Department does not have the closed record for the investigation. Assistant Deputy Director, Stephanie Cooke has approved this request. 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2293998'::character varying,
		null::date
 	) ;