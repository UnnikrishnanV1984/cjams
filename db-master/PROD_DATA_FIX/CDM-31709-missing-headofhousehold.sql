/*
   Issue Description: CDM-31709
   Category/ Module  : Persons
   Root cause: Missing head of household
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservicerequestactor set isheadofhousehold =true,updatedby ='CDM-31709' ,updatedon =now() where  intakeservicerequestactorid ='064a0c6d-dcc5-4993-9fd3-008d6f7da290';