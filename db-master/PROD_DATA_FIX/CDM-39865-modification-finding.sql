-- CDM-39865 - Finding ModificationRequest
/* Issue Description:CW2223926:Please modify this indicated neglect finding to Unsubstantiated neglect. 

-- Case ID: CW2223926 - 981809a1-5137-4ab7-8b4d-624c1c49606c/CW2223926

-- Category/ Module: Investigation Findings

-- Root cause: It was given as Indicated and was told to update to Unsubstantiated
-- Fix Provided: Datafix has been updated to Unsubstantiated from Indicated Service case # CW2223926
-- Pull request# N/A
*/




update tb_conv_inv_finding set investigation_finding_cd = 'Unsubstantiated' where referral_id='CW2223926';


