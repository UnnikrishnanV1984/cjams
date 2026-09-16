-- CDM-35646 - Finding ModificationRequest
/* Issue Description:CW2291155:Please modify this indicated neglect finding to Unsubstantiated neglect. 

-- Case ID: CW2291155 - 1adbf146-069e-4600-ab35-d20854d99f5f/CW2291155

-- Category/ Module: Investigation Findings

-- Root cause: It was given as Indicated and was told to update to Unsubstantiated
-- Fix Provided: Datafix has been updated to Unsubstantiated from Indicated Service case # CW2291155
-- Pull request# N/A
*/

update tb_conv_inv_finding set investigation_finding_cd = 'Unsubstantiated' where referral_id='CW2291155';