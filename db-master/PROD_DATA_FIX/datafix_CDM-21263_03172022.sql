-- CDM-21263 - Deletion
/*
-- Issue Description: 
	User request to expunge the following CPS-IR CW2147932 (Converted Indicated Investigation)
	Reason for deletion: Investigation record has been more than 25 years of record-keeping policy. 
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2147932 - 79df4ed6-01bc-494c-9c0d-41b316cd5de5
-- Converted : Sexual Abuse - Indicated

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2147932'::character varying,
		null::date
	) ;
