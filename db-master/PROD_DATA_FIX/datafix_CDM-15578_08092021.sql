-- CDM-15578 - Record deletion
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2147901 and CW2136678 (Converted Indicated Investigation)
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR CW2147901	- c2f7c543-916f-4c28-b7d2-d8d421a40a92
-- CPS-IR CW2136678 - 9ff7c153-07a1-46ed-b866-60b6602bbc06

-- with NO Maltreatment/Allegation & Findings (migrated data).

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2147901'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2136678'::character varying,
		null::date
	) ;

