-- CDM-29249 - Expungement
/*
-- Issue Description: 
	User request is for expunge the 1 CPS-IR Case CW2351162
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD, these are migrated CPS-AR cases and should have been expunged in the legacy system only.
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR & refferal  CW2351162 cases.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR : CW2351162
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2351162'::character varying,
		null::date
	) ;