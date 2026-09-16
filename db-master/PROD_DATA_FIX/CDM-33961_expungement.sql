-- CDM-33961 - Expungements
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2218524 as we have the Assistant Deputy Director, Stephanie Cooke has approved this expungement request.

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR # CW2218524
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR	CW2218524

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2218524'::character varying,
		null::date
	) ;

    