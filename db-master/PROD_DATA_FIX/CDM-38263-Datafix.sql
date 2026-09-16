-- CDM-38263- Expunge the case
/*
-- Issue Description: 
	User requested to expunge the CW2711839
	   
-- Root cause: User requested to expunge the case.

-- Fix provided: Datafix has been updated to expunge the  case # CW2711839 .
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



-- CPS-IR CW2711839

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2711839'::character varying,
		null::date
 	) ;