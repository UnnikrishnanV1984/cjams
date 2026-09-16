-- CDM-27894-Adoption Approval 
/*
File Name: CDM-27894-routing-AdoptionApproval
-- Issue Description: 
   For the Case Id 3282913: Case was assigned to Wrong supervisor Katie Cawthon , user wants us to assign to the right superviosr Brandi Hill.
   CLient Email ID :kathleen.king@maryland.gov

-- Resolution: Updated the activeflag to zero in the routing table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


--fb74bb50-fada-4647-83d0-766635c57d80
 update
	routing
set
	tosecurityusersid = 'e0362519-4fe0-424a-9360-7620e9031021',
	updatedby = 'CDM-27894',
	updatedon = now()
where
	routingid = '2af41ea6-0c27-48d3-b628-bdcbb1c65d61';
