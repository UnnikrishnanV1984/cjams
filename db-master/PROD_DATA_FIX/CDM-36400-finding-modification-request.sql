/*
-- CDM-36400 - Finding Modification Request
-- Focus Area:Decision
-- Fix Provided: modify indicated neglect finding to unsubstantiated neglect.
 * 
 */

-- Backup
select * from tb_conv_inv_finding where referral_id ='CW2276377';

-- Update query
UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Unsubstantiated'
where inv_finding_id=252318 and referral_id='CW2276377';