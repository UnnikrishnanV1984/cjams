/*
-- Issue Description: 
IR CW2217066 is associated only with a screened out intake I202000159341. Thus, I do not believe that IR should exist and am requesting it be expunged/deleted.	   
-- Root cause: User requested to expunge the case.

-- Fix provided: Datafix has been updated to expunge the  case # CW2217066 .
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2217066'::character varying,
		null::date
 	) ;