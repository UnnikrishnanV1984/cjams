/*
   Issue Description: CDM-23866
   Category/ Module  : Persons tab
   Root cause: user wants add missing person
   Pull request# for code fix: 5903
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update Intakeservicerequestactor set isprimary = true, updatedby ='CDM-23866', updatedon = now() 
	where intakeservicerequestactorid  ='8758bf76-08f5-4874-b50d-6932b12254d9' 
	and actorid  ='f8eb8cdf-6764-4c98-9c9e-a82bf0362533';