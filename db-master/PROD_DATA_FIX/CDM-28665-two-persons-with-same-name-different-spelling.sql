/* 
    Issue Description: CDM-28665
   Category/ Module  : persons tab
   Root cause: user wants to remove this person
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28665'
where actorid = 'b7a65c55-3ca6-4c09-93e6-b759cac13373';

update cjams.intakeservicerequestactor
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28665'
where intakeservicerequestactorid = '77f779d6-a28c-4376-bc76-1a8c8e51fc2f';

update cjams.personrole
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28665'
where personroleid in ('e987776b-4fff-41ab-aa9e-4f0446e11038','826b798c-c350-4bb7-81c0-503e919b13b6');

update cjams.actorrelationship
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28665'
where intakeservicerequestactorid  = '77f779d6-a28c-4376-bc76-1a8c8e51fc2f';

update personprogramarea 
set activeflag = 0 ,
    updatedon = now(),
    updatedby = 'CDM-28665'
where personprogramid in ('d413581e-dbb8-48d6-85c6-304ff5f0a552','a63db914-68e8-4b00-8b2d-f7f0b7821971');