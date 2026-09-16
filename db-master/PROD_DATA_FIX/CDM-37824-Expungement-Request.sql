/*
-- CDM-37824 - Expungement Request
-- Issue Description: User request To Expunge the Case CW2228655 as we have the SSA/Product Owner approval on that.
-- Category/ Module: Intake/Investigation (Expungement)
-- Root Cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge the Case CW2228655
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from tb_conv_inv_finding where referral_id = 'CW2228655';


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2228655'::character varying,
		null::date
	) ;