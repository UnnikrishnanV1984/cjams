-- CDM-29946 - Expungement
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2133036

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CPS-IR with NO Maltreatment/Allegation & Findings (CIS migrated data).
-- Fix Provided: Datafix has been promoted to expunge the CPS-IR # CW2133036
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR	CW2133036	4fd17ac0-4b03-48e0-bbc1-263abeb88180

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2133036'::character varying,
		null::date
	) ;

