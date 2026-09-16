-- CDM-27797 - Expungement
/*
-- Issue Description: 
	User request is for expunge the 1 CPS-ARs: 221020286773
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD, these are migrated CPS-AR cases and should have been expunged in the legacy system only.
-- Fix Provided: Datafix has been promoted to update expunge the CPS-AR 221020286773 case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS AR: 221020286773 

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'221020286773'::character varying,
		null::date
	) ;