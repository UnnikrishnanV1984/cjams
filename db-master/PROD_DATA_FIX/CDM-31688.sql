
/*
   Issue Description: CDM-31688
   Category/ Module  : 
   Root cause:user want to update Missing Person
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/

update intakeservicerequestactor set servicecaseid='5ee4c83e-c94e-49a8-a03f-b5b3908826ea',updatedby='CDM-31688',updatedon=now() 
where 
intakeservicerequestactorid in('b824542e-da27-41b4-a4ba-a9e4afe63d23','e55a6558-d2bb-4872-ade7-4053400d964b','a9a7ea57-4c4d-44e2-9d26-eb7f5130f8d0');