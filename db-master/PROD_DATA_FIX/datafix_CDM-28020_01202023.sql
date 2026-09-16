-- CDM-28020 - Expungement
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2499985

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: This is migrated CPS-IR case with no maltreatment data and should have been expunged by now.
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR # CW2499985
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR	CW2499985	d9a45432-331d-42bc-b1b0-4ba1a247b947
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2499985'::character varying,
		null::date
	) ;

