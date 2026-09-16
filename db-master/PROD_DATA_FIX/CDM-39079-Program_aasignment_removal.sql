/*
 * CDM-39089 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description -Please remove CIS # 473015392 program assignment from CJAMS Investigation#CW2245839. 
                 The department does not have the closed record for this investigation.
 */


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2245839'::character varying,
		null::date
 	) ;