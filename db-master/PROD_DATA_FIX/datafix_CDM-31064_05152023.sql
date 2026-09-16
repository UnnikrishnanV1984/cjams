-- CDM-31064 - Expungement
/*
-- Issue Description: 
	User request To Expunge CPS IR Case CW2147691

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CPS-IR with NO Maltreatment/Allegation & Findings (CIS migrated data).
--             CJAMS is not expunging such converted investigation with automated batch.
-- Fix Provided: Datafix has been promoted to expunge the CPS-IR # CW2147691
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR - CW2147691 - f2e3e5eb-2d5c-4e24-84b9-22bf37762773

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2147691'::character varying,
		null::date
	) ;
