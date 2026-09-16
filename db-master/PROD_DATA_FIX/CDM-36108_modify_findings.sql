-- CDM-36108 - Modify finding
/* Issue Description:User request to update finding to Unsubstantiated neglect that has been modified for #CW2661917

-- CaseId: CW2661917

-- Category/ Module: Decision

-- Root cause: User request to update finding to Unsubstantiated neglect that has been modified for #CW2661917 
-- Fix Provided: Datafix has been provided to update investigationfindingtypekey to Unsubstantiated
-- Pull request# N/A

*/

select * from investigationfinding 
where investigationfindingid in ('33efa731-4175-4ceb-a4ba-46c326f57843', '4c26ed15-3c9a-4ed2-b8ee-4438f2d67099','3add421d-a309-40ba-a265-4673d333c2e5');

update investigationfinding
set investigationfindingtypekey='UD',
updatedby='CDM-36108',
updatedon=now()
where investigationfindingid in ('33efa731-4175-4ceb-a4ba-46c326f57843', '4c26ed15-3c9a-4ed2-b8ee-4438f2d67099','3add421d-a309-40ba-a265-4673d333c2e5');