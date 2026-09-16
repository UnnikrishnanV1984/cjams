/*
    CDM-15981
    Root cause: Person is missing in the maltreatment allegation
*/
update intakeservicerequestactor set activeflag =  1, updatedon = now(), updatedby = 'CDM-15981' 
where intakeservicerequestactorid = 'b9ed5d51-a8e5-4c7d-b163-9cfd70328cbc';