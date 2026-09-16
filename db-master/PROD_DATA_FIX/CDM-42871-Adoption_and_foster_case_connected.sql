/*
 Issue Description: CDM-42871 Adoption and foster case conneted
 Category/ Module  : Placement
 Root cause: User error - Adoption and foster case conneted
 fix: Datafix has been added to remove the service case from cps case.
 Pull request# for code fix: 
 Reason why no related code fix: 

 */

 

UPDATE intakeservicerequest 
SET servicecaseid = null,
    updatedon = now(),
    updatedby = 'CDM-42871'
WHERE 
    intakeserviceid ='ff24f7df-b907-4db8-a867-8a6f61eeee76';
 
UPDATE intakeservicerequestactor
SET servicecaseid = null, 
    updatedon = now(),
    updatedby = 'CDM-42871'
WHERE 
    intakeserviceid = 'ff24f7df-b907-4db8-a867-8a6f61eeee76' 
    and personid ='c8cb3e22-1198-46de-8975-e9de0ef7f5d6';

update actor
set servicecaseid = null,
    updatedon = now(),
    updatedby ='CDM-42871'
    
where 
    actorid = 'a59993f3-b875-4a60-b7ca-79146514a145'
    and activeflag = 1;