-- CDM-20801 - Expungement
/*
-- Issue Description: 
	CPS-IR case number CW2878050 should have been expunged from the system by 12/15/2021. 
	The case was unsubstantiated and the 5 years has past. 
	User request to expunge this CPS-IR case # CW2878050
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2878050 - 295f5adc-fe99-4dc7-ac0e-e4c15cadfca1

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2878050'::character varying,
		null::date
	) ;
