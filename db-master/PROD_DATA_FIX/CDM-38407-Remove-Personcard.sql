/*
   Issue Description: CDM-38407
   Category/ Module  :  person card removal
   Root cause: user wants to remove thewrong person from case
   Fix Provided: Did data fix to remove person card  
*/

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CDM-38407', updatedon = now()
where intakeservicerequestactorid ='7df954b4-7366-4f91-b332-605574767761' and  personid ='d6725d5a-eb91-4295-9617-c3042e258e01' 
and servicecaseid ='b80bd382-e7d2-4069-a705-bc6e12f5c11f' and activeflag = 1;

--personrole
update personrole
set activeflag = 0,	updatedby = 'CDM-38407', updatedon = now()
where servicecaseid = 'b80bd382-e7d2-4069-a705-bc6e12f5c11f' and personid ='d6725d5a-eb91-4295-9617-c3042e258e01' and activeflag = 1 ;
    
update actor
set activeflag = 0,	updatedby = 'CDM-38407', updatedon = now()
where servicecaseid = 'b80bd382-e7d2-4069-a705-bc6e12f5c11f' and personid ='d6725d5a-eb91-4295-9617-c3042e258e01'
and actorid ='04d2ae7e-7660-4842-bc91-c80565e4ca59' and activeflag = 1 ;

update actorrelationship
set activeflag = 0,	updatedby = 'CDM-38407', updatedon = now()
where intakeservicerequestactorid ='7df954b4-7366-4f91-b332-605574767761' and activeflag = 1;
