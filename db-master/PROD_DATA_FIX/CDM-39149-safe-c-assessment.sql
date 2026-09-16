/*
   Issue Description: CDM-39149- Child's name disappeared on the Safe C in IR 241021916237
   Category/ Module  : Assessments: SAFE-C
   Root cause: After creating assessment child role was removed and then added back which inserted new record in the table
   Fix Provided: Data fix to include missing child details. Not updating audit columns as they are used in application 
*/

UPDATE cjams.assessmentactor
SET intakeservicerequestactorid='b506697e-2d1e-44e9-9795-72ac67936f94', updatedby='CDM-39149', updatedon=now()
WHERE assessmentactorid in ('12d93d75-f980-4c35-90d4-335cee83ba24') ;

UPDATE cjams.assessmentactor
SET intakeservicerequestactorid='aa0d75c9-5eec-487d-bb15-0e3c99b5d5de', updatedby='CDM-39149', updatedon=now()
WHERE assessmentactorid in ('d2a91965-321a-446f-950d-2c97b89af783') ;
