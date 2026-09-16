--CJAMS-59512  Removal Information Disappeared


/*
--	Issue Description: 
	The information regarding his removal has disappeared
-- Category/ Module: Services: Other
-- Root cause: The information regarding his removal has disappeared
-- Fix Provided: Datafix has been promoted to reappear the removal information.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

    
UPDATE intakeservreqchildremoval
  SET intakeservicerequestactorid = 'c6af7bcb-b592-4c68-8c53-cc492728bc06',
      updatedby = 'CJAMS-59512',
	  updatedon = now()
WHERE personid = '21e25147-7a1d-4de0-bdc0-34f81059a6d8' 
  and activeflag = 1;
