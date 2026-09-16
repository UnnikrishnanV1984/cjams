-- CDM-35239 - finding modification request
/*
-- Issue Description: 
	User request To finding modification CPS Case CW2212240.

-- Category/ Module: Intake/Investigation (Finding modification request)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge/updated to Unsubstatiated Neglect the CPS-IR # CW2212240
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from cjams.tb_conv_inv_finding where referral_id ='CW2212240';

update cjams.tb_conv_inv_finding 
set investigation_finding_cd = 'Unsubstantiated'
where referral_id in ('CW2212240') and investigation_finding_cd = 'Indicated';