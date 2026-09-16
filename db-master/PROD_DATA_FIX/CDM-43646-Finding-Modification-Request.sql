/*
-- Issue Description: 
	User request is for expunge thecase
	   
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
set investigation_finding_cd='Ruled Out', maltreatment_type_cd ='Neglect'
where referral_id='CW2265280' and inv_finding_id=241221;