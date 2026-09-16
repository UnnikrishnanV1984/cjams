-- CDM-15272 - Case expungement
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2075343 (Converted Indicated Investigation)
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR - CW2075343 - f56b8c7d-6a5e-4f7b-ba6c-a80eef0605e9
-- with NO Maltreatment/Allegation & Findings (migrated data).

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2075343'::character varying,
		null::date
	) ;
