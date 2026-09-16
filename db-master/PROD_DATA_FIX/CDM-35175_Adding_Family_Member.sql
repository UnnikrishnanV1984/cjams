-- CDM-35175 - Adding Family Member
/*
 -- Issue Description: In this case, a memeber of household is not being displayed.
 -- Category/ Module: homedashboard
 -- Root cause: Servicecaseid and actorid are not mapped correctly.
 -- Fix Provided: Datafix has been added by updating the servicecaseid against relevant actorID.
 -- Pull request# N/A 
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 */


update actor 
set servicecaseid='5626f603-bf9d-4f52-9f31-cc2cb503d5c3', updatedby='CDM-35175', updatedon=now() 
where actorid='1335b093-da0e-4210-854e-05025dfe11bd' and personid='f4e8f0fb-27e7-4128-8dd7-d8b6cc67f000';