/* 
    Issue Description: CJAMS-67340
   Category/ Module  : Expungement Request
   Root cause: Data fix for expunging the case CW2223603 and CW2223604. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2223603'::character varying,
		null::date
	) ;


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2223604'::character varying,
		null::date
	) ;