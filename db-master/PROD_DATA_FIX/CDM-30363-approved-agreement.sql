/*
-- CDM-30363- 
-- Issue Description: 
 Approvals not deleting from case pending approval inbox
-- Root cause: Data fix updated the activeflag to 0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-30363',
    updatedon = now()
where
    routingid = '3a09a9de-a24b-4cc2-b7c7-d1469a607c14';