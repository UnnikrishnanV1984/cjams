/*
-- CDM-31681 - Expungement Request
-- Issue Description: 
	User request To Expunge Case CW2211436 as we have the SSA/Product Owner approval on that.
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge the # CW2211436
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from tb_conv_inv_finding where referral_id = 'CW2211436';


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2211436'::character varying,
		null::date
	) ;