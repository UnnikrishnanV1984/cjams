-- CDM-42586- 
/* Issue Description:There is no case number connected to the GAP

-- Client Id: 3637750
-- Casenumber: 3236684
-- Service Case: d02447e9-f97b-4b0d-999d-4b296d4e4872
-- Person Id: 3475551f-91fd-4fcc-901b-e2d50d7b29b6

-- Category/ Module: Title-IVE(GAP) 

-- Root cause: There is no case number connected to the GAP, As inactive actorid is mapped in the childremoval table, so there is no case number linked to the GAP. 
-- Fix Provided: Datafix has been provided to update active actorid in childremoval
-- Pull request# N/A

*/

UPDATE cjams.intakeservreqchildremoval
SET intakeservicerequestactorid='70041386-acd0-48b2-bec7-a77fa5527b63'::uuid, 
updatedby = 'CDM-42586',
updatedon = now()
WHERE intakeservreqchildremovalid='fe3c2cff-dcbb-48ba-b32d-c3570c74a863'::uuid;
