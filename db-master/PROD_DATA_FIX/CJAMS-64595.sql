
/*
-- Issue Description: Unable to process
-- Root cause: The user submitted ACA for review several times since 1/7/26. But it's showing up approvals but not disappearing from ACA list. The worker has sent an email stating Adoption subsidy will be delayed due to this bug. They want the date for when they initially sent this for approval
-- Fix Provided: Datafix has been provided to update the IV-E Specialty date and IV-E Supervisor date to the date when the worker initially sent this for approval.
-- Regression Impacts: N/A
-- Is Code fix Required?: No
-- Code fix ticket#: N/A
-- Reason why no related code fix: User error, no code fix needed.
-- Status of the code fix: Data fix completed, PR raised for documentation.
*/
update tb_ive_adoption_audit
set decisionsubmissiondate ='2025-12-21 00:00:00', decisionresubmissiondate ='2025-12-21 00:00:00',
updatedon=now(),
updatedby ='CJAMS-64595'
where cjamspid = 4215598 and adoptionauditid ='105907';