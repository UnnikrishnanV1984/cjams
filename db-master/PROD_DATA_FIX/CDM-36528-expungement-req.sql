-- CDM-36528 - Expungement Request
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2265601
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR CW2265601


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2265601'::character varying,
		null::date
 	) ;