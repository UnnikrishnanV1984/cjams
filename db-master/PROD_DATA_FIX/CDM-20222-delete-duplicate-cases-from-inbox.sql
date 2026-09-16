/*
-- CDM-20222 - 

-- Issue Description: 
 Approvals not deleting from case pending approval inbox
  
-- Customer Email ID:markeeta.dixon@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# 4934
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag =0, updatedby = 'CDM-20222', updatedon = now() where routingid in ('1c4a11c8-fc2b-4191-82ac-345fe97eb8a2', 
'ac90d7a1-095c-402c-8ecb-ccaddf2a9428','704a5cbc-49c2-422f-88f8-0a16e38b3760');