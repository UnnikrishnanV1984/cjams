-- CDM-24962 - Expungement
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2036787 (Converted Indicated)
	
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2036787 - c5e81e71-8af0-405e-a2ec-5576f232260f
-- Converted : Physical Abuse - Indicated

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2036787'::character varying,
		null::date
	) ;
