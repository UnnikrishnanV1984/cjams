-- CDM-39576 - Expungement
/*
-- Issue Description: 
	User request is for expunge the 1 CPS-IRs: CW22722git18
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: 
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR CW2272218 case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2272218

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2272218'::character varying,
		null::date
	) ;