-- CDM-27030 - Expungement
/*
-- Issue Description: 
	User has updated the Finding as 'Unsubstantiated' and request to expunge the CPS-IR CW2443308 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: N/A
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2443308 - 1d18734f-6cf4-4802-a57a-3bd73782447f

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2443308'::character varying,
		null::date
	) ;
