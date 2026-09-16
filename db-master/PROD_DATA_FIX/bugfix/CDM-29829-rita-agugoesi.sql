/*
-- Issue Description: 
	CDM-29829-rita-agugoesi-stuck-approvals-3-30-23
	 Category/ Module: 
     -- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

update routing set activeflag = 0,updatedby = 'CDM-29829', updatedon = now()
where routingid in ('2b301c44-4fab-435b-a261-b88ca253651f','1279af12-8a98-4f20-abef-6cdc3c29ae7f','4a12027d-3937-4762-83e6-b83648fc6260')
