/*
   Issue Description: CDM-29360
   Category/ Module  : Case Assignment
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
-- servicerequestnumber='221020276970'
UPDATE cjams.caseassignment
SET updatedby='CDM-29360', updatedon=now(), enddate=null
WHERE caseassignmentid='99f3344b-8f18-44e6-a741-f5ae13e74050' and objectid='f654e93c-5b2f-4fc6-a49a-23a594f37546';

UPDATE cjams.intakeservicerequestdispositioncode
SET updatedby='CDM-29360', updatedon=now(), activeflag = 0
WHERE intakeservicerequestdispositioncodeid in ('5ea6c9d4-05dc-42b2-ade6-fd03cf7237e1','962ba7e0-1461-4e2c-93cb-c67691d60b97',
'c54f70d9-d7e9-47e5-a485-e46336747231','c63e6881-fb38-40b8-a54f-323471d72f2a') and intakeserviceid='f654e93c-5b2f-4fc6-a49a-23a594f37546';

UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby='CDM-29360', updatedon=now()
WHERE intakeserviceid='f654e93c-5b2f-4fc6-a49a-23a594f37546';

