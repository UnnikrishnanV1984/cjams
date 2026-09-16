/*
-- Issue Description: 
	   The record for Case # CW2295407 was requested pursuant to a background clearance application for CIS ID#, 030837611but could not be located.
        Please modify the finding to Ruled Out and immediately expunge.

-- Category/ Module: Intake/Investigation (Finding modification request)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge/updated to Unsubstatiated Neglect the CPS-IR # CW2212240
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2295407' and inv_finding_id=271348;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2295407'::character varying,
		null::date
 	) ;