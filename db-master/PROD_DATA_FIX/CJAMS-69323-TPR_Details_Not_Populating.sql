/*
-- Issue Description: 
	TPR not populating
	   
-- Category/ Module: 
-- Root cause: No parents are associcated with the courthearing which is causing the Parentdetails not available while saving TPR popup
-- Fix provided: Datafix has been provided by updating the courthearing with specified parents mentioned in the ticket
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


  UPDATE cjams.intakeservicerequestcourthearing
SET
    parent1actorid  = '6d1c8618-14c7-4ee4-bf18-b14062045bcf'::uuid,
    parent1personid = '25ac5576-92be-4ab4-91e2-702d2cdf65a0'::uuid,
    parent1name     = 'KYERA B THOMPSON',
    parent1unknown  = false,
    updatedon       = now(),
    updatedby       = 'CJAMS-69323'
WHERE intakeservicerequestcourthearingid = '0130ed8f-0444-4490-be3f-27f8e199b2fd'::uuid
  AND activeflag = 1;
  
   UPDATE cjams.intakeservicerequestcourthearing
SET
    parent2actorid  = '3fe75681-9eed-453b-9f0e-6c0a91bf21ea'::uuid,
    parent2personid = '28fe8efb-44c8-4779-b850-e0c2a339a90c'::uuid,
    parent2name     = 'Kaine Keith Unknown father',
    parent2unknown  = false,
    updatedon       = now(),
    updatedby       = 'CJAMS-69323'
WHERE intakeservicerequestcourthearingid = '0130ed8f-0444-4490-be3f-27f8e199b2fd'::uuid
  AND activeflag = 1;
  

 
   UPDATE cjams.intakeservicerequestcourthearing
SET
    parent1actorid  = '6d1c8618-14c7-4ee4-bf18-b14062045bcf'::uuid,
    parent1personid = '25ac5576-92be-4ab4-91e2-702d2cdf65a0'::uuid,
    parent1name     = 'KYERA B THOMPSON',
    parent1unknown  = false,
    updatedon       = now(),
    updatedby       = 'CJAMS-69323'
WHERE intakeservicerequestcourthearingid = '80c58f7c-e6ab-4119-9544-1e033df1872d'::uuid
  AND activeflag = 1;
  
   UPDATE cjams.intakeservicerequestcourthearing
SET
    parent2actorid  = '3fe37f67-0606-4ca3-a949-1371d3d91dd6'::uuid,
    parent2personid = 'ec58cd17-e651-4ba7-9990-01dfa7384209'::uuid,
    parent2name     = 'UNKNOWN FATHER messiah thompson',
    parent2unknown  = false,
    updatedon       = now(),
    updatedby       = 'CJAMS-69323'
WHERE intakeservicerequestcourthearingid = '80c58f7c-e6ab-4119-9544-1e033df1872d'::uuid
  AND activeflag = 1;
  
 
    UPDATE cjams.intakeservicerequestcourthearing
SET
    parent1actorid  = '6d1c8618-14c7-4ee4-bf18-b14062045bcf'::uuid,
    parent1personid = '25ac5576-92be-4ab4-91e2-702d2cdf65a0'::uuid,
    parent1name     = 'KYERA B THOMPSON',
    parent1unknown  = false,
    updatedon       = now(),
    updatedby       = 'CJAMS-69323'
WHERE intakeservicerequestcourthearingid = 'e397e684-7aad-4bd0-befe-950710bdf96b'::uuid
  AND activeflag = 1;
  
   UPDATE cjams.intakeservicerequestcourthearing
SET
    parent2actorid  = '3fe75681-9eed-453b-9f0e-6c0a91bf21ea'::uuid,
    parent2personid = '28fe8efb-44c8-4779-b850-e0c2a339a90c'::uuid,
    parent2name     = 'KAINE KEITH Unknown father',
    parent2unknown  = false,
    updatedon       = now(),
    updatedby       = 'CJAMS-69323'
WHERE intakeservicerequestcourthearingid = 'e397e684-7aad-4bd0-befe-950710bdf96b'::uuid
  AND activeflag = 1;
