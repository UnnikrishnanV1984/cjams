-- CDM-41422 - Expungement
/*
-- Issue Description: 
	User request is for expunge the 1 CPS-IR Case CW2851273
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CPS-IR Investigation 2851273, should have been expunged 11/4/2020. Case was unsubstantiated.
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR CW2851273 cases.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR : CW2851273
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2851273'::character varying,
		null::date
	) ;