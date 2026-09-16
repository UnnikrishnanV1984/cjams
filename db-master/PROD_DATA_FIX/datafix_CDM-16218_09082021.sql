-- CDM-16218 - Expungement
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2849507 and CPS-AR CW2868218. 
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
       
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/
	
-- CPS-IR CW2849507	- ebf83d5a-aee4-45a9-b469-afa247dfa6f1
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2849507'::character varying,
		null::date
	) ;

-- CPS-AR CW2868218	was expunged with the fix for CDM-16219.