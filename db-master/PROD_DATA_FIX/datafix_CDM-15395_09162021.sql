-- CDM-15395 - Expungement
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2146235 (Converted Indicated Investigation)
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR CW2146235 - 781ed81d-2658-414d-9c46-60744bc8f742
-- with NO Maltreatment/Allegation & Findings (migrated data).

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2146235'::character varying,
		null::date
	) ;
