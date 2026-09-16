-- CDM-20838-Task in Inbox cannot be approved
/*
-- Issue Description: 
	1.User is not able to approve the task and asking to delete from his queue
	
-- Root cause: 
---Fix : This case is updated as with active flah to zero

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update routing set activeflag = 0, updatedby = 'CDM-20838', updatedon=now() where routingid = '26b6af7a-ad9b-46ea-8138-e5b9f78f2b29';
