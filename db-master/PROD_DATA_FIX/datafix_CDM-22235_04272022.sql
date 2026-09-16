-- CDM-22235 - Deletion
/*
-- Issue Description: 
	User request to expunge the following CPS-IR CW2182118 (Converted Indicated Investigation)
	Reason for deletion: Investigation record has been more than 25 years of record-keeping policy. 
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: N/A
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2182118 - 4a436d4a-b79f-4f25-af0f-74cc9966f00f
-- Converted : Physical Abuse - Indicated

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2182118'::character varying,
		null::date
	) ;
