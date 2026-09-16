-- CDM-36194 - Finding ModificationRequest
/* Issue Description:CW2276375:Finding Modification Request.

-- Case ID: CW2276375 - 4b2631f9-fbb7-4819-a96d-4349e7752549/CW2276375

-- Category/ Module: Investigation Findings

-- Root cause: It was given as Indicated and was told to update to Ruled out
-- Fix Provided: Datafix has been updated to Ruled out from Indicated Service case # CW2276375
-- Pull request# N/A
*/



select * from tb_conv_inv_finding where referral_id='CW2276375';


update tb_conv_inv_finding set investigation_finding_cd = 'Ruled Out' where referral_id='CW2276375';