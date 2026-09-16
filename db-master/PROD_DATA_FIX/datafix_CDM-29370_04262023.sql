-- CDM-29370 - Case Expungement
/*
-- Issue Description: 
	User request To Expunge CPS Alternative Response CW2922149

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: Migrated CPS AR case CW2922149 should have been expunged on 10/22/2021, MD CHESSIE did not expunge this. 
-- Fix Provided: Datafix has been promoted to expunge the CPS-AR # CW2922149. 
--				 After verifying there is no subsequent case received for any the involved person in the case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-AR	CW2922149	8d2777ae-2a8d-4dda-a26c-c0b5633cade4

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2922149'::character varying,
		null::date
	) ;
