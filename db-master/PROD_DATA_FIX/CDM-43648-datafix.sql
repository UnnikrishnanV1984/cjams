/*
 Issue Description: CDM-43648
-- Category/ Module: Investigation Finding 
-- Root cause: Use requested to ruled out
-- Fix Provided: Datafix has been promoted to ruled out the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
*/

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled out'
where referral_id = 'CW2220151';