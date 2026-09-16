-- CDM-42435 - Missing removal address
/* Issue Description: Parent1id  is causing an issue in loading events

-- Client Id: 2741266
-- Removalid: 191489

-- Category/ Module: Title IVE 

-- Root cause: Parent1id with null is causing an issue in loading events
-- Fix Provided: Datafix has been provided to update parent1id
-- Pull request# N/A

*/

update intakeservreqchildremoval
set parent1id = 2741269, 
updatedon  = now(),
updatedby  = 'CDM-42435'
where intakeservreqchildremovalid  = '26ab7098-29de-45ba-8c76-5b9b2c8e1c65';