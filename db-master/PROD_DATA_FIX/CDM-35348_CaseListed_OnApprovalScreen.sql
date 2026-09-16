-- CDM-35348 - case listed on approval screen
/*
 -- Issue Description: In this case, Case #231021008486 has appeared on this supervisor's Approval Inbox screen with an event description of Case Connect Review. This case needs to be deleted
 
 -- Category/ Module: Cjamsdashboard
 -- Fix Provided: Datafix has been added by setting the active flag to 0 for the respective service case.
 -- Pull request# N/A 
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 -- Root Cause: Service case connection was not created to the case but routingID was created in routing table.
 -- Fix: Data fix by deleting the record from the routing table.
 */
update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-35348',
    updatedon = now()
where
    objectid = '580fd7cb-9ef7-4d85-9fa4-2da57ae9164c'
    and eventcode = 'SCCR';