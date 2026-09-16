/*
-- CDM-36544 - Expungement Request
-- Issue Description: 
	User request To Expunge CPS Case CW2283390.
	The Department does not have the closed record for this investigation. 
	Assistant Deputy Director, Stephanie Cooke has approved this expungement request.
-- Category/Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Fix Provided: Datafix has been provided to update expunge the # CW2283390
-- Pull request# N/A 
-- Reason why no related code fix: N/A
*/

select * from tb_conv_inv_finding where referral_id = 'CW2283390';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2283390'::character varying,
		null::date
	) ;