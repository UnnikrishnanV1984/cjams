/*
-- CDM-20830 - 

-- Issue Description: 
 Duplicate Approvals in case pending approval inbox
  
-- Customer Email ID:lisa.late@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag =0, updatedby = 'CDM-20830', updatedon = now() where routingid in ('f7eb1a70-e02b-4118-87a6-a576f328c323','2327ab21-b534-4b81-89a6-0be9409f7552',
'9b9fc532-faf5-4789-a041-276040611628','8aba4065-b3d4-48ff-8d90-000891b89d94','de1e3052-7c99-4762-ae7a-dbe00c1f98a9','63b64443-6c0e-4615-8c0a-8241a3c182f2',
'95017a57-b10b-428c-b335-32c1370e7132','e3df6db7-663e-4727-bebd-f0890c06ee4f');