/*
   Issue Description: CDM-29477-Adding head of house hold
   Category/ Module  : CDM
   Pull request# for code fix: 
   Reason why no related code fix: User needs to upate a HOH
   Status of the code fix if already submitted and expected prod fix date: 

*/

update intakeservicerequestactor 
set isheadofhousehold=true,updatedby = 'CDM-29477', updatedon = now() where
servicecaseid='0362005e-3171-4ac3-9926-e419e1d4f757' 
and personid='3b95e80c-7e70-47cc-9369-40b0c44e1138' 
and intakeservicerequestactorid='e675b68f-77f5-4beb-9fcf-ec622fb755e3';