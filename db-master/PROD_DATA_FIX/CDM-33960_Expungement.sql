-- CDM-33960 - Expungement
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2240050 

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause:CW2240050:Please expunge this investigation.
-- Fix Provided: Datafix has been promoted to expunge #CW2240050
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



SELECT vl_sqlcode, vs_err_message
FROM cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2240050'::character varying,
		null::date
	) ;