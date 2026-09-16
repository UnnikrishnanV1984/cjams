-- CDM-35230 - Expungements
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2243568 as we have the SSA/Product Owner approval on that.

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR # CW2243568
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR	CW2243568	19607eef-2e0a-415e-8dc0-0870954be50f/CW2243568


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2243568'::character varying,
		null::date
	) ;