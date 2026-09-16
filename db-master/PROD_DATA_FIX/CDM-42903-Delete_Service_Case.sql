/*
 Issue Description: CDM-42903 Remove case connection and Delete service case
 Category/ Module  : Placement
 Root cause: User error - Adoption and foster case conneted
 fix: Datafix has been added to remove the service case from cps case.
 Pull request# for code fix: 
 Reason why no related code fix: 

 */


update servicecase 
set activeflag =0, 
    updatedby = 'CDM-42903', 
    updatedon = now() 
where 
    servicecaseid = '3694e0f9-e219-4fc9-a0b1-a1126c09ad33';

update caseassignment 
set activeflag = 0, 
    updatedby = 'CDM-42903', 
    updatedon = now() 
where 
    objectid = '3694e0f9-e219-4fc9-a0b1-a1126c09ad33' and activeflag = 1 ;

update servicecasedisposition 
set activeflag = 0, 
    updatedby = 'CDM-42903', 
    updatedon = now() 
where 
    servicecaseid = '3694e0f9-e219-4fc9-a0b1-a1126c09ad33';


UPDATE intakeservicerequest 
SET servicecaseid = null,
    updatedon = now(),
    updatedby = 'CDM-42903'
WHERE 
   servicecaseid = '3694e0f9-e219-4fc9-a0b1-a1126c09ad33' 
   and activeflag =1;
 
  
update routing 
set activeflag = 0, 
    updatedby = 'CDM-42903', 
    updatedon = now() 
where 
    objectid = '3694e0f9-e219-4fc9-a0b1-a1126c09ad33' 
    and activeflag = 1;
    
   
update actor 
set activeflag = 0, 
    updatedby = 'CDM-42903', 
    updatedon = now() 
    where 
        servicecaseid = '3694e0f9-e219-4fc9-a0b1-a1126c09ad33' 
        and activeflag = 1;
    
update intakeservicerequestactor 
set activeflag = 0, 
    updatedby = 'CDM-42903', 
    updatedon = now() 
where 
    servicecaseid = '3694e0f9-e219-4fc9-a0b1-a1126c09ad33' 
    and activeflag = 1; 