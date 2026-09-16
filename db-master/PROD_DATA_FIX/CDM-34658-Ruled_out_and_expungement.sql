/*
-- Issue Description: 
	User request is for expunge the 1 CPS-IRs: CW2152015
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: 
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR CW2152015 case.
-- Pull request# N/A 
-- Reason why no related code fix:CIS Converted Investigation with No information about maltreator or the maltreatment/allegation. 
                 CJAMS is not expunging such CIS converted investigations with automated batch. 
                 So, we are expunging these CIS Investigations with SSA approvals.
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2152015' and inv_finding_id=146536;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2152015'::character varying,
		null::date
 	) ;