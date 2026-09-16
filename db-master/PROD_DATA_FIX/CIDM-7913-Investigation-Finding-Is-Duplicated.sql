-- CDM-35175 - Adding Family Member
/*
 -- Issue Description: In this case, investigation is duplicated
 -- Category/ Module: homedashboard
 -- Root cause: Two records were created.
 -- Fix Provided: Datafix has been added by deleting the record against investigation allegation id and allegation id.
 -- Pull request# N/A 
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 */


update
    investigationallegation
set
    activeflag = 0,
    updatedby = 'CIDM-7913',
    updatedon = now()
where
    investigationallegationid = 'e7241daa-d73e-42fa-b2ae-7b5f52937652'
    and allegationid = '2482ea5f-2cfa-434c-b2e7-e0501371b961';