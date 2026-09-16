/*
-- Issue Description: 
	TPR not populating in adoption planning
	   
-- Category/ Module: 
-- Root cause: No parents are associcated with the courthearing which is causing the Parentdetails not available while saving TPR popup
-- Fix provided: Datafix has been provided by updating the courthearing with specified parents mentioned in the ticket
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE cjams.intakeservicerequestcourthearing
SET
    parent1actorid  = '3bbaad60-2978-4ff3-9ef9-031b02e9ede8'::uuid,
    parent1personid = 'bb3f25c0-ea9b-4acc-96dd-56cfad609e55'::uuid,
    parent1name     = 'Kevin M Casey',
    parent1unknown  = false,
    updatedon       = now(),
    updatedby       = 'CJAMS-69324'
WHERE intakeservicerequestcourthearingid = 'e87d39ba-09f9-4b36-86f5-049214f9168f'::uuid
  AND activeflag = 1;
 
  UPDATE cjams.intakeservicerequestcourthearing
SET
    parent2actorid  = 'a0d2caf1-06e4-4cf2-ae37-26a76aab1f9d'::uuid,
    parent2personid = '6bc50f72-bff5-4cdf-a694-7873ece5340c'::uuid,
    parent2name     = 'SERENITY L CHADWICK',
    parent2unknown  = false,
    updatedon       = now(),
    updatedby       = 'CJAMS-69324'
WHERE intakeservicerequestcourthearingid = 'e87d39ba-09f9-4b36-86f5-049214f9168f'::uuid
  AND activeflag = 1;