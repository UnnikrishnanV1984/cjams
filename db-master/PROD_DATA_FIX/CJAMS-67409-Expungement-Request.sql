/* 
    Issue Description: CJAMS-67409
   Category/ Module  : Expungement Request
   Root cause: Data fix for expunging the case
   CW2225032 CW2225030 CW2225029 CW2225024 CW2225020 CW2225021 CW2225028 CW2225026 CW2225027
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2225032'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2225030'::character varying,
		null::date
	) ;


    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2225029'::character varying,
		null::date
	) ;

    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2225024'::character varying,
		null::date
	) ;


    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2225020'::character varying,
		null::date
	) ;


    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2225021'::character varying,
		null::date
	) ;

    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2225028'::character varying,
		null::date
	) ;


    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2225026'::character varying,
		null::date
	) ;



    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2225027'::character varying,
		null::date
	) ;

    
