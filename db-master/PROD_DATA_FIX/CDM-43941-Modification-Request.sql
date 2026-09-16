/*
 Issue Description: CDM-43941
-- Category/ Module: Investigation Finding 
-- Root cause: User wants to update investigation finding from Indicated to Ruled Out  
-- Fix Provided: Datafix has been promoted to update the investigation finding 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out' 
where inv_finding_id=17707 and referral_id='CW2007906';