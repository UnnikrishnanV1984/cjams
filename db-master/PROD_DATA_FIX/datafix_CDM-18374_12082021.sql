-- CDM-18374 - Expungement
/*
-- Issue Description: 
	User request to expunge the following CPS-IR CW2080738 (Converted Indicated Investigation)
	Reason for deletion: The record and archive has no record of the investigation. 
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2080738 - 6fd6c117-1914-4bfa-9e6f-dde1846f1f23

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2080738'::character varying,
		null::date
	) ;
