/*
 * CDM-39939 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - Please remove CIS # 476008356 program assignment from CJAMS investigation # CW2274569 and CW2292628. The department does not have the closed records for the investigations.
 * Assistant Deputy Director, Stephanie Cooke has approved this request.
 * data fix for expunging the case
 * 
 */


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2274569'::character varying,
		null::date
 	) ;

 
 
 select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2292628'::character varying,
		null::date
 	) ;