-- CDM-15951 - Rrecord deletion
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2165908 (Converted Indicated Investigation)
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR CW2165908	- ab81c461-3e40-45c2-8a40-521c3dc629d6
-- with NO Maltreatment/Allegation & Findings (migrated data).

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2165908'::character varying,
		null::date
	) ;
