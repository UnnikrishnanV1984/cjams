/*
 * CDM-40081 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - :Please remove CIS# 030834147 from the following CJAMS investigations:CW2273265,CW2273266,CW2241083,CW2241084,CW2241082.
 * Assistant Deputy Director, Stephanie Cooke has approved this request.
 * data fix for expunging the case
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2273265'::character varying,
		null::date
 	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2273266'::character varying,
		null::date
 	) ;



select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2241084'::character varying,
		null::date
 	) ;




select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2241083'::character varying,
		null::date
 	) ;


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2241082'::character varying,
		null::date
 	) ;
