/*
-- CW2158976 - Expungements
-- Issue Description: User request To Expunge Case CW2158976 as we have the SSA/Product Owner approval on that.
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge the # CW2158976
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from tb_conv_inv_finding where referral_id = 'CW2158976';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2158976'::character varying,
		null::date
	) ;