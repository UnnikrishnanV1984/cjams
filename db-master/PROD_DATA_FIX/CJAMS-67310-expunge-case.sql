/* 
   Issue Description: CJAMS-67310
   Category/ Module  : Expungement Request
   Root cause: Data fix for expunging the case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   void the rejected provider placement from backend
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2210604'::character varying,
		null::date
	);
