/*
-- CDM-28263 - CPS Intake and Referral need Expunged 
-- Issue Description: 
	Dashboard:This is another record that should be expunged.
	CW2290847
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2290847'::character varying,
		null::date
	);	