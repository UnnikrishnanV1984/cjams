/*
    Issue description: CDM-40029
    -- Category/Module: IR
    -- Root cause: The record routingstatustypeid was 1 instead of 8
    -- Pull request: N/A
    -- Reason why no related fix: N/A
    -- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cjams.routing
set routingstatustypeid = 8, activeflag = 0,
updatedby = 'CDM-40029', updatedon = now()
where routingid = '299f107d-524d-4275-a05c-f7f7f12619f5';