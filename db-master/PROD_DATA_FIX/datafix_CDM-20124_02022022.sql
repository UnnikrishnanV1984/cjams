-- CDM-20124 - Expungement
/*
-- Issue Description: 
	User request to expunge the following CPS-IR CW2166373 (Converted Indicated Investigation)
	Reason for deletion: This case has been modified to unsubstaniated child physical abuse on paper
	and should now be expunged. CJAMS does not allow this action a this is a migrated data.
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: N/A
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2166373 - 995819d9-2fc3-4a2d-96b1-7ca4cf73f7b3
-- Physical Abuse - Indicated	

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2166373'::character varying,
		null::date
	) ;

