/*
 Issue Description: CDM-43236
-- Category/ Module: Pending Approval
-- Root cause: User requested to remove the pending approval from supervisor dashboard
-- Fix Provided: Datafix has been promoted to update the approval flag.
-- Pull request# N/A
-- Reason why no related code fix: User requested to update the approval flag.
*/


update routing
set activeflag = 0, updatedon = now(), updatedby = 'CDM-43236'
where routingid = '1bdc15fe-4136-402e-bed2-b406caac824c' 
      and objectid = 'fbf8a10e-5373-47cf-ace4-e718f147a87b' 
      and activeflag = 1;