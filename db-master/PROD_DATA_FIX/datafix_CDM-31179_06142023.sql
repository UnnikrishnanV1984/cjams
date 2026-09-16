-- CDM-31179 - Finding change
/*
-- Issue Description: 
	User request To Expunge CPS IR Case CW2060965 (Converted Data)

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation.
-- Fix provided: Datafix has been promoted to expunge the requested CPS IR case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR - CW2060965 - 77e7c198-c87d-4b69-b368-b280396488af
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2060965'::character varying,
		null::date
	) ;
