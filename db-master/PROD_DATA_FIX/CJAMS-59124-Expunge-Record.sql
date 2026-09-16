/*
-- Issue Description: 
This case needs to be expunged in the system. The physical record no longer exists and was destroyed by the State Records Management Center in January 2024 (see attached).
-- Root cause: User requested to expunge the case.
-- Fix provided: Datafix has been updated to expunge the  case # CW2089385 .
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2089385'::character varying,
		null::date
 	) ;