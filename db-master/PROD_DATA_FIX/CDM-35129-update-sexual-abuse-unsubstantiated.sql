-- CDM-35129 - Finding Modification
/* Issue Description:CW2236649:Please modify this indicated neglect finding to Unsubstantiated neglect. 

-- Case ID: CW2236649 - ea3e3997-5068-43f8-87cc-6c9059ff36e4

-- Category/ Module: Investigation Findings

-- Root cause: It was given as Indicated and was told to update to Unsubstantiated
-- Fix Provided: Datafix has been updated to Unsubstantiated from Indicated Service case # CW2236649
-- Pull request# N/A
*/

update tb_conv_inv_finding set investigation_finding_cd = 'Unsubstantiated' where maltreatment_type_cd='Sexual Abuse' and referral_id='CW2236649';