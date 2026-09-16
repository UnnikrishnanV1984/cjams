/*
Issue Description: CDM-43318 - Case showing in approvals of all supervisors to be assigned and it is assigned.
-- Category/ Module: Supervisor case assignment Dashboard 
-- Root cause: Service Case# 241030419355 is still displayed under user (theresa.kleppinger@maryland.gov) "To be Assigned" dashboard.
              This case is already assigned and needs to be removed from the dashboard. Code fix is already done and data fix needed
              to remove the case from dashboard.
-- Fix Provided: Datafix has been promoted to remove the case from to be assigned Dashbaord
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update servicecase
set statustypekey = 'ASSGN',
    updatedby = 'CDM-43318',
    updatedon = now()
where servicecaseid = '4acec0f1-ffde-4f3a-a438-160869287a41';