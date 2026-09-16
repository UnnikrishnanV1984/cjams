/*
   Issue Description: CDM-30779
   Category/ Module  : Case Assignment
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
-- servicerequestnumber='231020396510'



UPDATE cjams.intakeservicerequestdispositioncode
SET updatedby='CDM-30779', updatedon=now(), activeflag = 0
WHERE intakeservicerequestdispositioncodeid in ('d572ed44-6dee-4c52-b91a-f0d51e63cd77'); 


UPDATE cjams.caseassignment
SET updatedby='CDM-30779', updatedon=now(), enddate=null
WHERE caseassignmentid='92174b34-22c4-41b0-ac69-87b34ec96652';


UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby='CDM-30779', updatedon=now()
WHERE intakeserviceid='24bc1f0a-7419-4fc0-8925-64b64a0a2a00';