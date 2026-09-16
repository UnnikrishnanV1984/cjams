-- CDM-29688 - Expungements
/*
-- Issue Description: 
	Please expunge the case # CW2949248 as it is not reflected in Production.
	We have SSA/Product Owner approval for that case # on ticket # CDM-28530

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD, we are waiting for business users confirmation on the CPS AR expungement rules,  
--	           we will revisit the CPS AR expungement logic.
-- Fix Provided: Datafix has been promoted to update expunge the CPS-AR # CW2949248
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-AR	CW2949248	5f48daf4-dadd-4076-a1da-e6f69c2bf568
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2949248'::character varying,
		null::date
	) ;
