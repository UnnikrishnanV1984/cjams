-- CDM-16220 - Expungement
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2835308 (Converted Indicated Investigation)
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR CW2835308	- 2ac6e438-6134-436e-9aa6-1db27058a4de

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2835308'::character varying,
		null::date
	) ;

