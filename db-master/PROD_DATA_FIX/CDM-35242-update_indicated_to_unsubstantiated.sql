-- CDM-35242 - Finding ModificationRequest
/* Issue Description:CW2294373:Please modify this indicated neglect finding to Unsubstantiated neglect. 

-- Case ID: CW2294373 - fcfbc2f0-76c0-4ae3-9a33-6f318a068d25/CW2294373

-- Category/ Module: Investigation Findings

-- Root cause: It was given as Indicated and was told to update to Unsubstantiated
-- Fix Provided: Datafix has been updated to Unsubstantiated from Indicated Service case # CW2294373
-- Pull request# N/A
*/

update tb_conv_inv_finding set investigation_finding_cd = 'Unsubstantiated' where referral_id='CW2294373';