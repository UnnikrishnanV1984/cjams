-- CDM-35245 - Expungements
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2261215 as we have the SSA/Product Owner approval on that.

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR # CW2261215
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR	CW2261215	37f8b067-c15d-461d-a7f9-6aa316fda252/CW2261215


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2261215'::character varying,
		null::date
	) ;