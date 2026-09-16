-- CDM-18375 - Expungement
/*
-- Issue Description: 
	User request to expunge the following CPS-IR CW2100559 (Converted Indicated Investigation)
	Reason for deletion: The record and archive has no record of the investigation. 
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 1239088 (KIRSTEN EADS) - 586f44ce-e9c6-4e60-9d87-97b6ba0bd1e2
-- CPS IR: CW2100559 - 73799931-4eb0-430c-94cc-3cc66ec7ab78	

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2100559'::character varying,
		null::date
	) ;

