-- CDM-16389 - Expungement
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2096247 and CW2096246 (Converted Indicated Investigation)
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR CW2096247	- 7ce36759-b3c8-41e1-90da-2bb82f48d2f5
-- with NO Maltreatment/Allegation & Findings (migrated data).

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2096247'::character varying,
		null::date
	) ;

-- CPS-IR CW2096246	- 0b891eed-b321-4685-b3f5-3c132222fff8
-- with NO Maltreatment/Allegation & Findings (migrated data).

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2096246'::character varying,
		null::date
	) ;
