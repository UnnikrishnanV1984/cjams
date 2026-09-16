
/*
   Issue Description: CDM-15106
   Category/ Module  :  Reopening CPS Case
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--null 	642f18b0-ef6e-4d4b-9871-acc0734f3f5a
update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= NOW(), updatedby='CDM-15106'
where intakeserviceid = '55eeacec-09ac-4a6c-9c50-df9f66c3667f';

-- 2021-07-14 00:00:00
update caseassignment set enddate = null, updatedon= NOW(), updatedby='CDM-15106' where caseassignmentid = '2a0fca12-2245-4fe1-89ac-9db78b6216c2';
