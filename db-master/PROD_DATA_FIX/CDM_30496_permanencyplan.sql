-- CDM-30496 - permanencyplan
/*
-- Issue Description: In case #3275172 (HOH: Rajame Cooper), youth, Diamond Brown, permanency plan has disappeared from the CJAMS record

-- Category/ Module: permanencyplan
-- Root cause: Multiple submisions
-- Fix Provided: Datafix has been promoted added the intakeservicerequestactorid as 57811add-30ed-4cde-a9cb-0ef62253b9a1
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--intakeservicerequestactorid was null
update
	permanencyplan
set
	intakeservicerequestactorid = '57811add-30ed-4cde-a9cb-0ef62253b9a1',
	updatedby = 'CDM-30496',
	updatedon = now()
where
	permanencyplanid = '38e3d572-57bd-4bc7-b3a4-a97ffc8c2d77';

