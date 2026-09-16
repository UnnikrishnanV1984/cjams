-- CDM-38476- Expungment Request
/*
-- Issue Description: 
	User requested to expunge the CW2254701, CW2254702
	   
-- Root cause: User requested to expunge the case.

-- Fix provided: Datafix has been updated to expunge the  case # CW2254701,CW2254702 .
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



-- CPS-IR CW2254701
-- CPS-IR CW2254702

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2254701'::character varying,
		null::date
 	) ;
 	
 select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2254702'::character varying,
		null::date
 	) ;