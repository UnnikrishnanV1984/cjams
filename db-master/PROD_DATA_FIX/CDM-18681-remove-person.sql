/*
   Issue Description: CDM-18681
   Category/ Module  : remove person
   Root cause: user wants to remove person from intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update intakeservicerequestactor set activeflag =0, updatedby ='CDM-18681',updatedon = now() where intakeservicerequestactorid ='bfc9adc3-73ee-421b-a12e-77709206a54e';