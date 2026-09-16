/*
-- CDM-20786 - 

-- Issue Description: 
 Duplicate Approvals in case pending approval inbox
  
-- Customer Email ID:shawnae.lowery@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag =0, updatedby = 'CDM-20786', updatedon = now() where routingid in ('663fc6b4-fe4d-483f-baf3-eb3292459968','2b1f90b4-f029-43ce-a468-37db98072766','675728ed-477e-41ba-babf-20a3922b0cf5',
'3694cd5c-c323-442d-b1b4-8b5d257b28d7','1a68a99f-2c57-4d2b-96e9-d300ff222636','88d3e603-a12f-4be8-9e37-cf8cde3d039c','7bdabd60-905c-402d-bd24-8b429a6403df');