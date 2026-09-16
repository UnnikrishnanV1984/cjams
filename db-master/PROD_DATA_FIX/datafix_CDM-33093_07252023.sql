-- CDM-33093 - System Defect
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2426831 (Converted Indicated Investigations)
	   
-- CPS-IR - CW2426831 - 6c2ecb91-7b07-42c1-b974-fc3836ffc654
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: MD CHESSIE did not expunge this CPS case back in 2013 after completion of 5 years retention period.
-- Fix provided: Datafix has been promoted to expunge the CPS IR case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To expunge the Converted CPS IR cases (CDM-33093)

-- Datafix has been promoted to expunge the requested CPS-IR case (Converted Indicated Investigations)

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2426831'::character varying,
		null::date
	) ;

