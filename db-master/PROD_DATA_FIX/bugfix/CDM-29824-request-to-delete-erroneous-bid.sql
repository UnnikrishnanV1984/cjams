/*
-- Issue Description: 
	CDM-29824-request-to-delete-erroneous-bid
	 Category/ Module: 
     -- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

update assessment set activeflag = 0,updatedby = 'CDM-29824',updatedon = now()
where assessmentid = 'd9c8ab9f-6b43-4cfe-9b1c-a62c49b5a23f';