
/*
   Issue Description: CDM-33991
   Category/ Module  : Person
   Root cause: Insertion is missing on case connect seanrion 
   Fix Privided: Did data fix to add that case to the servicecase  
*/

update cjams.intakeservicerequestactor set servicecaseid  ='8c17377d-ebde-4523-9f96-e09068ee68b4', updatedby='CDM-33991', updatedon = now()
where intakeservicerequestactorid  ='54320193-72f8-4f58-bbf3-0de84388b546';