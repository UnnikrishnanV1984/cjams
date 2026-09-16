-- CDM-36613 - Expungements
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2288321 as we have the SSA/Product Owner approval on that.
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR # CW2288321
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR	CW2288321

select * from tb_conv_inv_finding where referral_id ='CW2288321';

/*
update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where referral_id = 'CW2288321';
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2288321'::character varying,
		null::date
	) ;