/*
 Issue Description: CDM-42829
-- Category/ Module: Investigation Finding 
-- Root cause: Use requested to expunge the Case 
-- Fix Provided: Datafix has been promoted to expunge the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2046091'::character varying,
		null::date
	);
