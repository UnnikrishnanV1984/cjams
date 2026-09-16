-- CDM-35239 - finding modification request
/*
-- Issue Description: 
	User request To finding modification CPS Case CW2043191.

-- Category/ Module: Intake/Investigation (Finding modification request)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge/updated to Unsubstatiated Neglect the CPS-IR # CW2043191
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where referral_id = 'CW2043191';

SELECT vl_sqlcode, vs_err_message
FROM cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2043191'::character varying,
		null::date
	) ;