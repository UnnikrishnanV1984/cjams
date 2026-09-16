/*
 Issue Description: CDM-43258
-- Category/ Module: Service Plan
-- Root cause: User requested to remove the service plan
-- Fix Provided: Datafix has been promoted to update the approval flag.
-- Pull request# N/A
-- Reason why no related code fix: User requested to remove the service plan.
*/


update serviceplan 
set activeflag = 0, updatedby = 'CDM-43258',updatedon = now()
where serviceplanid = 'fdef15ef-4316-47c4-839f-132acbd28354' and activeflag = 1;