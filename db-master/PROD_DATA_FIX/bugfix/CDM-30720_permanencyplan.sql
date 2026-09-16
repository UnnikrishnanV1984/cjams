/*
   Issue Description: CDM-30720
   Category/ Module : Permanency Plan
   Root cause:  Intakeservicerequestactorid is null (Not able to replicate this issue in stage3)
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Data fix: Updating activeflag to 0 in the routing table for the servicerequest
*/

UPDATE cjams.permanencyplan
SET intakeservicerequestactorid='ee4a349e-81a2-465e-8622-f3230a22ca02', updatedon=now(), updatedby='CDM-30720'
WHERE permanencyplanid='b7ef5e98-e0ac-4a2a-a961-1c7adf351f35';
