-- CDM-18034 - Expungement
/*
-- Issue Description: 
	User request to expunge the CPS-AR case # CW2921732
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS AR: CW2921732 - a3dca561-8217-419f-90cd-f8f3dd99f5da

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2921732'::character varying,
		null::date
	) ;
