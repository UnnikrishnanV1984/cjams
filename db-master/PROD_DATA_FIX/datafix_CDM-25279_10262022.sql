-- CDM-25279 - Remove from database
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2278237 (Converted Indicated)
	
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2278237 - c1594e22-fb05-4bdc-a4e5-261423827e74
-- Converted : Neglect - Indicated

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2278237'::character varying,
		null::date
	) ;
