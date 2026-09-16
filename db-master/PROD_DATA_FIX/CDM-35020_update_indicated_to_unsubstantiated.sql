-- CDM-35020 - Finding ModificationRequest
/* Issue Description:CW2276378:Please modify this indicated neglect finding to Unsubstantiated neglect. 

-- Case ID: CW2276378 - 8a55050d-8672-4053-845d-3362236b598d

-- Category/ Module: Investigation Findings

-- Root cause: It was given as Indicated and was told to update to Unsubstantiated
-- Fix Provided: Datafix has been updated to Unsubstantiated from Indicated Service case # CW2276378
-- Pull request# N/A
*/

update tb_conv_inv_finding set investigation_finding_cd = 'Unsubstantiated' where referral_id='CW2276378';
