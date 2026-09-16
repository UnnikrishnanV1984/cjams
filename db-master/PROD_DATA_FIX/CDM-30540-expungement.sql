-- CDM-30540 - Expungement
/*
-- Issue Description: 
	User request is for expunge the 1 CPS-ARs: CW2936678
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: 
-- Fix Provided: Datafix has been promoted to update expunge the CPS-AR CW2936678 case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS AR: CW2936678

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2936678'::character varying,
		null::date
	) ;