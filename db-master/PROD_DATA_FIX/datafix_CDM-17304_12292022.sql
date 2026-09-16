-- CDM-17304 - Expungement
/*
-- Issue Description: 
	User request is for expunge the 2 CPS-ARs: CW2851222 and CW2869081

-- CPS AR: CW2851222 - 21399d66-5b90-4703-a49e-9f279448a96c
-- CPS AR: CW2869081 - fb2749e8-fe1a-44e8-8020-41bddfca85b4
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD, these are migrated CPS-AR cases and should have been expunged in the legacy system only.
-- Fix Provided: Datafix has been promoted to update expunge the CPS-AR CW2851222 & CW2869081 cases.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS AR: CW2851222 - 21399d66-5b90-4703-a49e-9f279448a96c

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2851222'::character varying,
		null::date
	) ;


-- CPS AR: CW2869081 - fb2749e8-fe1a-44e8-8020-41bddfca85b4

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2869081'::character varying,
		null::date
	) ;
	
