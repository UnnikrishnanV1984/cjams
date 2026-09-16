/*
 Issue Description: CJAMS-68254- Intake is somewhere but unknown where- it won't allow us to save or change things
 Category/ Module  : Application/Dashboard
 Root cause: User requested to delete the intake and case
 fix required: Datafix has been done to remove the service case and intake.
 Is code fix required: N 
 why no code fix is required: User error
 Pull request# for code fix: 
 Reason why no related code fix: 
*/


select * from CW_transactions_dataclenup('INTKE','I261014095697','CJAMS-68254');


update servicecase 
set activeflag =0, 
    updatedby = 'CJAMS-68254', 
    updatedon = now() 
where 
    servicecaseid = '1e19f11f-edd0-4949-a6a2-16f92d6e1773';

update caseassignment 
set activeflag = 0, 
    updatedby = 'CJAMS-68254', 
    updatedon = now() 
where 
    objectid = '1e19f11f-edd0-4949-a6a2-16f92d6e1773' and activeflag = 1 ;

update servicecasedisposition 
set activeflag = 0, 
    updatedby = 'CJAMS-68254', 
    updatedon = now() 
where 
    servicecaseid = '1e19f11f-edd0-4949-a6a2-16f92d6e1773';

 
  
update routing 
set activeflag = 0, 
    updatedby = 'CJAMS-68254', 
    updatedon = now() 
where 
    objectid = '1e19f11f-edd0-4949-a6a2-16f92d6e1773' 
    and activeflag = 1;
    
   
update actor 
set activeflag = 0, 
    updatedby = 'CJAMS-68254', 
    updatedon = now() 
    where 
        servicecaseid = '1e19f11f-edd0-4949-a6a2-16f92d6e1773' 
        and activeflag = 1;
    
update intakeservicerequestactor 
set activeflag = 0, 
    updatedby = 'CJAMS-68254', 
    updatedon = now() 
where 
    servicecaseid = '1e19f11f-edd0-4949-a6a2-16f92d6e1773' 
    and activeflag = 1; 