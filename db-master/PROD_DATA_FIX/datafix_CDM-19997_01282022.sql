-- CDM-19997 - Case expungement
/*
-- Issue Description: 
	User request to expunge the following CPS-IR CW2284811 (Converted Indicated Investigation)
	Reason for deletion: The LDSS is unable to locate the paper record. 
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2284811 - 4ba5049d-ea9d-4849-8663-d00d9c94dbad

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2284811'::character varying,
		null::date
	) ;
