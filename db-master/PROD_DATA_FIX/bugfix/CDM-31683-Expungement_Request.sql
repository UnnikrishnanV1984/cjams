-- CDM-31683 - Expungement
/*
-- Issue Description: 
	User request is for expunge the 1 CPS-IR Case CW2233998	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: Expunge this investigation from the system. 
    Stephanie Cooke, Assistant Deputy Director has approved the expungement request due to the Department not having the record for this investigation.
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR CW2233998 cases.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR : CW2233998
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2233998'::character varying,
		null::date
	) ;