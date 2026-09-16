-- CDM-26429 - Approval stuck
/*
-- Issue Description: 
	1. Permanency plan has been approved and continues to show in the supervisor approvals 

-- Category/ Module: Approval Inbox
-- Root cause: User Request
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select 	activeflag, * from 	routing 
where 	routingid = 'ba4e5316-6cf3-4b61-b5ec-a6fa8b2ae8cb';

update 	routing 
set		activeflag = 0,
		updatedon  = now(),
		updatedby  = 'CDM-26429'
where 	routingid = 'ba4e5316-6cf3-4b61-b5ec-a6fa8b2ae8cb';