/*
 * CDM-39386 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - Please remove CIS # 030865137 program assignments from CJAMS investigations CW2259531, CW2259532, and CW2259529. 
       The Department does not have the closed records for the investigations.
       Assistant Deputy Director, Stephanie Cooke has approved this request. 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2259529'::character varying,
		null::date
 	) ;


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2259531'::character varying,
		null::date
 	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2259532'::character varying,
		null::date
 	) ;
