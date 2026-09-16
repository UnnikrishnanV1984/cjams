-- CDM-27318-Override Case to close
/*
   File Name: CDM-27318-assessment-OverrideCase
-- Issue Description: 
    For the case 211030008557 User created a case closure contact but not able to send the safec assessment for approval, 
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
	updatedby = 'CDM-27318',
	updatedon = now()
where
	assessmentid = 'e077fb6d-1007-4405-875a-90d5c136da23';