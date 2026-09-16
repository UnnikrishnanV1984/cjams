/*
   Issue Description: CDM-43721
   Category/ Module  :  Case Search
   Root cause: User requeseted to expunge AR case
-- Fix Provided: Datafix has been promoted to expunge the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2939799'::character varying,
		null::date
	) ;