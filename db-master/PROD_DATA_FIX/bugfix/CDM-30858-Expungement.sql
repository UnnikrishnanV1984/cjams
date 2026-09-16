/*
   Issue Description: CDM-30858
   Category/ Module  : 
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- CPS-AR	CW2949396	981e06b5-bedf-47b7-953e-7479f61b6bf5
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2949396'::character varying,
		null::date
	) ;