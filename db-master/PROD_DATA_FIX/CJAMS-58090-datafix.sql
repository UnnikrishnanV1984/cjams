/*
 Issue Description: CDM-58090- Referral screened out but still generated case
 Category/ Module  : Application/Dashboard
 Root cause: case is screenedout but a service case is created
 fix: Datafix has been added to remove the service case .
 Pull request# for code fix: 
 Reason why no related code fix: 
*/

update servicecase 
set activeflag =0, 
    updatedby = 'CJAMS-58090', 
    updatedon = now() 
where 
    servicecaseid = 'b45b4a47-28e6-4851-b07d-b5fd81244adb';

update caseassignment 
set activeflag = 0, 
    updatedby = 'CJAMS-58090', 
    updatedon = now() 
where 
    objectid = 'b45b4a47-28e6-4851-b07d-b5fd81244adb' and activeflag = 1 ;

update servicecasedisposition 
set activeflag = 0, 
    updatedby = 'CJAMS-58090', 
    updatedon = now() 
where 
    servicecaseid = 'b45b4a47-28e6-4851-b07d-b5fd81244adb';

 
  
update routing 
set activeflag = 0, 
    updatedby = 'CJAMS-58090', 
    updatedon = now() 
where 
    objectid = 'b45b4a47-28e6-4851-b07d-b5fd81244adb' 
    and activeflag = 1;
    
   
update actor 
set activeflag = 0, 
    updatedby = 'CJAMS-58090', 
    updatedon = now() 
    where 
        servicecaseid = 'b45b4a47-28e6-4851-b07d-b5fd81244adb' 
        and activeflag = 1;
    
update intakeservicerequestactor 
set activeflag = 0, 
    updatedby = 'CJAMS-58090', 
    updatedon = now() 
where 
    servicecaseid = 'b45b4a47-28e6-4851-b07d-b5fd81244adb' 
    and activeflag = 1; 