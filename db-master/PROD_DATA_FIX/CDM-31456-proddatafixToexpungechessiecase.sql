-- CDM-314566 - Expungement
/*
-- Issue Description: 
	User request To Expunge CPS IR Case CW2184997

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: Migrated Indicated Investigation and the finding was updated to Unsubstantiated in CJAMS after the 5 years retention period.
--             Since the expungement due date has already been past, CJAMS is not going to expunge this case.
-- Fix Provided: Datafix has been promoted to expunge the CPS-IR # CW2184997
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2184997'::character varying,
		null::date
	) ;