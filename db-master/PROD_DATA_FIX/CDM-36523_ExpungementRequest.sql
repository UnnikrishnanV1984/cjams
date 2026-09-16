/*
-- CDM-36523 - Expungement Request
-- Issue Description: 
	User request To Expunge Case CW2247147.
	The Department does not have the closed record for this investigation. 
	Assistant Deputy Director, Stephanie Cooke has approved this expungement request.
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge the CW2247147
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from tb_conv_inv_finding where referral_id = 'CW2247147';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2247147'::character varying,
		null::date
	) ;