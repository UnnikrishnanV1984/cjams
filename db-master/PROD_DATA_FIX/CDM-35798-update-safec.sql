
/*
  Issue Description: CDM-35798 Approved SAFE-C/SAFE-C OHP unchecked
   Category/ Module  :  user management
   Root cause: I am seeking assistance with this case I am unable to submit this case for closure because the  Approved SAFE-C/SAFE-C OHP box is that is listed under the review checklist is unchecked
   Fix Provided: Datafix has been promoted to update the intakeserviceid in assesintakeservicerequestactor table as it is missing intakeserviceid.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1 
*/
-- email:'dena.scott@maryland.gov'




update intakeservicerequestactor set intakeserviceid='1ebac0dd-9d4e-4b48-9880-c415c5be4eaa'
where intakeservicerequestactorid in ('417aef4c-2e36-4127-be04-21473dcd977e', '6a442317-032c-4724-a26b-50f0aa0012dc', '73802239-4a42-4c9d-82d4-b260333dabff');

