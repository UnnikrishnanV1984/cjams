-- CDM-27031 - expungement
/*
-- Issue Description: 
	User has updated the Finding as 'Unsubstantiated' and request to expunge the CPS-IR CW2701611 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: N/A
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2701611 - 39749781-8603-47ec-9c06-069d3606eec6

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2701611'::character varying,
		null::date
	) ;
