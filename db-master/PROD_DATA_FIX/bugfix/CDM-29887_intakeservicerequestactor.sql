/*
   Issue Description: CDM-29887
   Category/ Module  : Person not showing on person card
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.intakeservicerequestactor
SET  isprimary=true, updatedon=now(), updatedby='CDM-29887'
WHERE intakeservicerequestactorid='aed3f230-5c9b-448a-bdde-23645d0ede11' and servicecaseid='17fce8aa-8aa8-496a-809c-993cc29e8d8a';
