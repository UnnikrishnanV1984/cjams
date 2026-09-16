-- CDM-27741 - Expungement
/*
-- Issue Description: 
	User request is for expunge the 1 CPS-ARs & Referal: CW2020225
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD, these are migrated CPS-AR cases and should have been expunged in the legacy system only.
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR & refferal  CW2020225 cases.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR : CW2020225
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2020225'::character varying,
		null::date
	) ;