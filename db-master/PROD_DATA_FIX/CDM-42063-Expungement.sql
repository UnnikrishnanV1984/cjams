/*
-- CDM-42063-Expungement
-- Issue Description: 
IR-CW2928987 should have been expungemend 2/6/19.
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: 	User request To Expunge Case IR-CW2928987 should have been expungemend 2/6/19.
-- Fix Provided: Datafix has been promoted to update expunge the # CW2928987
-- Pull request# N/A 
-- Reason why no related code fix: For expunging the case, it needs to be dealed with the run of SQL batch.
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2928987'::character varying,
		null::date
	) ;