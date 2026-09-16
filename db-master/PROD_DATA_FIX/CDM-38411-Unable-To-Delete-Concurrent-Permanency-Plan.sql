-- CDM-38411 - Unable to Delete the concurrent permanency plan 
/*
-- Issue Description: Data fix is needed to remove the concurrent permanency plan as it can be edited once it's approved.
-- Case ID: 3201955,
-- Category/ Module: PermanencyPlan
-- Root cause: Concurrency plan type needs to be deleted so that caseworker can edit it once approved
-- Resolution: Datafix has provided by updating the concurrencytype column from guardianship to null in permanencyplan and permanencyplan_history tables
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update permanencyplan 
set concurrentpermanencytype = null,
    updatedby = 'CDM-38411', 
    updatedon = now()
where permanencyplanid = 'bf1ec144-91a1-4687-84ad-459b64f2a015'
and activeflag = 1;


update permanencyplan_history 
set concurrentpermanencytype = null,
    updatedby = 'CDM-38411', 
    updatedon = now()
where permanencyplanid = 'bf1ec144-91a1-4687-84ad-459b64f2a015'
and activeflag = 1;