-- CDM-29753 - Expungement
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2377941

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: When attempting to expunge Case Number CW2377941( originated From MD Chessie). 
			  The expunge link is not located under the action column under Expungement in Investigation Finding..
-- Fix Provided: Datafix has been promoted to expunge the CPS-IR # CW2377941
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2377941'::character varying,
		null::date
	) ;

