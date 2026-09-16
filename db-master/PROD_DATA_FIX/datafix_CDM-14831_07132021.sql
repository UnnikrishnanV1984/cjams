-- CDM-14831 - Expungement
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2283264 (Converted Unsubstantiated)
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR - CW2283264 - c12c2bc8-d137-41f9-a71c-9f1a839e2159 - Converted Unsubstantiated
-- with NO Maltreatment/Allegation & Findings (migrated data).

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2283264'::character varying,
		null::date
	) ;

