-- CDM-29685 - Expungements
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2839183 as we have the SSA/Product Owner approval on that.

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR # CW2499985
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-AR	CW2839183	af05c312-b0d4-435c-ae2f-dbd7133e1324
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2839183'::character varying,
		null::date
	) ;
