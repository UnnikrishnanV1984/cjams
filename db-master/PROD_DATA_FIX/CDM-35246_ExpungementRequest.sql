-- CDM-35246 - Expungements
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2211999 as we have the SSA/Product Owner approval on that.

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR # CW2211999
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR	CW2211999

select * from tb_conv_inv_finding where referral_id ='CW2211999';

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2211999';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2211999'::character varying,
		null::date
	) ;