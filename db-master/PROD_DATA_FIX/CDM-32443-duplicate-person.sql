/*
   Issue Description: CDM-32443
   Category/ Module  :Person
   Root cause: user requested to remove the duplicate peson in Person tab
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/
update intakeservicerequestactor set isprimary =false,updatedby ='CDM-32443',updatedon =now() where intakeservicerequestactorid ='acd5368c-4648-43b9-bb1a-e737085db702';