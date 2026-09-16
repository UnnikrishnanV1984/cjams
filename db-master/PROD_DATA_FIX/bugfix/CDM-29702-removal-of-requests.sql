/*
-- Issue Description: 
	CDM-29702-removal-of-requests
	 Category/ Module: 
     -- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

update routing 
set activeflag =0,updatedby = 'CDM-29702', updatedon = now()
where routingid in('4b4b70b4-8394-4332-be0b-ba170413e1e6','8747fe4c-6d23-4fd9-89a2-40f3aad11871');