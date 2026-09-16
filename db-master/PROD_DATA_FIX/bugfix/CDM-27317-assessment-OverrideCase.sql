-- CDM-27317-Override Case to close
/*
   File Name: CDM-27317-assessment-OverrideCase
-- Issue Description: 
    For the case User created a case closure contact but not able to send the safec assessment for approval, 
	when user clicks on submit for approval, user is getting popup to enter child information and unable to submit.
	Now user wants us to change the safe-c to APPROVED.
Customer Email ID:lori.hogan@maryland.gov
  
-- Resolution: Updated the assessmentstatustypekey to Accepted in the assessment table.

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update
	assessment
set
	assessmentstatustypekey = 'Accepted',
	updatedby = 'CDM-27317',
	updatedon = now()
where
	assessmentid = '742a8531-7efc-4efb-a8a1-79bc7ee8f19d';