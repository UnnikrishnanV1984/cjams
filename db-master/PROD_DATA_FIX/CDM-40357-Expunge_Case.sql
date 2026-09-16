
/*
 Issue Description: CDM-40357
-- Category/ Module: Investigation Finding 
-- Root cause: User wants to expunge the Case 
-- Fix Provided: Datafix has been promoted to expunge the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2731753'::character varying,
		null::date
	) ;
	
	
	