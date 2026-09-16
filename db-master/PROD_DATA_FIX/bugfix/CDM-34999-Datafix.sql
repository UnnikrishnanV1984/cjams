/*
   Issue Description: CDM-35999
   Category/ Module  : Expungement of case
   Root cause: user wants to  expunge
   Pull request# for code fix:
   Reason why no related code fix: user error
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2055664'::character varying,
		null::date
	);