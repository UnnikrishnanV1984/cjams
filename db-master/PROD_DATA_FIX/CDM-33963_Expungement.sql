-- CDM-33963 - Expungement
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2293942 

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause:CW2293942:Please expunge this investigation.
-- Fix Provided: Datafix has been promoted to expunge #CW2293942
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



SELECT vl_sqlcode, vs_err_message
FROM cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2293942'::character varying,
		null::date
	) ;
