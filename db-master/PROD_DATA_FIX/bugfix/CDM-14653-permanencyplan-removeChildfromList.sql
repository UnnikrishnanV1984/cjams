-- CDM-14653 -Child in the list does not belong in this case
/*
   File Name: CDM-14653-permanencyplan-removeChildfromList
-- Issue Description: 
    For the case 3265188  - Sisler does not belong in this GAP case. He needs removed from this case.
    Customer Email ID:kellie.warnick@maryland.gov
  
-- Resolution: Updated the Flag to zero in the permanencyplan table for the servicerequestnumbers ('3265188')

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update
	permanencyplan
set
	activeflag = 0 ,
	updatedon = now(),
	updatedby = 'CDM-14653'
where
	permanencyplanid = '7ff3e9e9-0fea-4d9e-a418-987a89b02b74'
	and activeflag = 1
	and servicecaseid = '8f4d2866-9c8c-4b99-8bc7-666c6853ba16';