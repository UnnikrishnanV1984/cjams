-- CDM-35385 - finding modification request
/*
-- Issue Description: 
	User request To update CPS Case CW2219147.

-- Category/ Module: Intake/Investigation (Modification request)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge/updated to Unsubstatiated Physical Abuse the CPS-IR # CW2219147
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from cjams.tb_conv_inv_finding where referral_id ='CW2219147';

update cjams.tb_conv_inv_finding 
set investigation_finding_cd = 'Unsubstantiated'
where referral_id in ('CW2219147') and investigation_finding_cd = 'Indicated';