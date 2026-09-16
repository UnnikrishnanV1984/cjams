-- CDM-22009 - Updated Information
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2239258 (Converted Unsubstantiated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2239258 - 95099665-d796-4094-9650-5ccf5a84ddbd
-- Converted : Neglect	- Unsubstantiated	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2239258'::character varying,
		null::date
	) ;
