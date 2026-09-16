/*
   Issue Description: CDM-17464
   Category/ Module  :  remove person from case
   Root cause: user wants to remove person from case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-17464', updatedon = now() where intakeservicerequestactorid ='51537e6d-33ec-401f-a0ae-184fd4623fae' and activeflag = 1;


update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-17464', updatedon = now() where intakeservicerequestactorid ='bfec0008-f05c-4ce7-919e-30dd5ac8f1dc' and activeflag = 1;