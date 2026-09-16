-- CDM-35963 - Finding ModificationRequest
/* Issue Description:CW2246556:Please modify this indicated neglect finding to Unsubstantiated neglect. 

-- Case ID: CW2246556 - 7a6631a9-16a6-4bb5-923b-cc2263d9debb/CW2246556

-- Category/ Module: Investigation Findings

-- Root cause: It was given as Indicated and was told to update to Unsubstantiated
-- Fix Provided: Datafix has been updated to Unsubstantiated from Indicated Service case # CW2246556
-- Pull request# N/A
*/


select * from tb_conv_inv_finding where referral_id='CW2246556';

update tb_conv_inv_finding set investigation_finding_cd = 'Unsubstantiated' where referral_id='CW2246556';
