/*
   Issue Description: CDM-16033
   Category/ Module  :  Data fix for missing permanency plans
   Root cause: NA
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update permanencyplan set intakeservicerequestactorid = 'a5c914eb-46d2-4aed-a66b-d2c78ebd9636', updatedby = 'CDM-16033', updatedon = now() where permanencyplanid = 'faf31d77-90c4-45d8-9483-cc21fd212365'
