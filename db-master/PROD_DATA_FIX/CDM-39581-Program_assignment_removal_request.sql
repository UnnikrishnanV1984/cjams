/*
 * CDM-39581 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description -Please remove CIS # 030836569 program assignment from CJAMS investigation # CW2270704, CW2242338, CW2242337, and CW2270703.
 * Assistant Deputy Director, Stephanie Cooke has approved this request.
 * expunge case # CW2270704, CW2242338, CW2242337, and CW2270703 as requested.
 */


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2270704'::character varying,
		null::date) ;

 select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2242338'::character varying,
		null::date
 	) ;


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2242337'::character varying,
		null::date
 	) ;

 select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2270703'::character varying,
		null::date
 	) ;
