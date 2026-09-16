/*
 * CDM-39443 - Maltreatment and AR summary deleted
 * Customer Email ID:vanessa.carrasco@maryland.gov
 * Description - 241022063891:The maltreatment allegation and AR summary were deleted from this case.
 * the Maltreatment Allegation has not been saved and AR summary has been submitted for supervisor review.
 * 
 */

--SELECT  intakeservicerequestactorid  , * FROM  Investigationallegationmaltreators 
--WHERE  investigationallegationid  =  '28d3b408-888e-4a78-964b-8d66b2ed2490';
UPDATE cjams.investigationallegationmaltreators
SET intakeservicerequestactorid='beeb3704-80aa-4474-b0ba-acfbb6c3f6fd', updatedby='CDM-39443', updatedon=now() 
WHERE investigationallegationid  =  '28d3b408-888e-4a78-964b-8d66b2ed2490';

