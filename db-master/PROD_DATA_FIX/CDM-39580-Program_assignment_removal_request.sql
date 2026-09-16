/*
 * CDM-3958 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description -Please remove CIS # 494014169 from the following cases in CJAMS:CW2245664,CW2245662,CW2245661,CW2245660,CW2245655,CW2245659,CW2245658,CW2245654,CW2245663,CW2245657,CW2245656.
 * Assistant Deputy Director, Stephanie Cooke has approved this request.
 */


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2245664'::character varying,
		null::date
 	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2245662'::character varying,
		null::date
 	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2245661'::character varying,
		null::date
 	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2245660'::character varying,
		null::date
 	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2245655'::character varying,
		null::date
 	) ;

 select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2245659'::character varying,
		null::date
 	) ;
    
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2245658'::character varying,
		null::date
 	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2245654'::character varying,
		null::date
 	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2245663'::character varying,
		null::date
 	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2245657'::character varying,
		null::date
 	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2245656'::character varying,
		null::date
 	) ;
