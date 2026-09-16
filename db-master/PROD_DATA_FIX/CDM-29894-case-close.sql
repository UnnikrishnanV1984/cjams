/*
   Issue Description: CDM-29360
   Category/ Module  : Case Decision
   Root cause: close the case as per user request 
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.caseassignment
SET updatedby='CDM-29360', updatedon=now(), enddate='2023-03-09 12:20:00'
WHERE caseassignmentid='99f3344b-8f18-44e6-a741-f5ae13e74050' and objectid='f654e93c-5b2f-4fc6-a49a-23a594f37546';

UPDATE cjams.intakeservicerequestdispositioncode
SET updatedby='CDM-29360',servicerequesttypeconfigiddispostionid = '02a89a40-85bf-47d0-adc6-6e4f0bea9465', updatedon=now(),  activeflag = 1
WHERE intakeservicerequestdispositioncodeid in ('5ea6c9d4-05dc-42b2-ade6-fd03cf7237e1') and intakeserviceid='f654e93c-5b2f-4fc6-a49a-23a594f37546';

UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby='CDM-29360', updatedon=now()
WHERE intakeserviceid='f654e93c-5b2f-4fc6-a49a-23a594f37546';