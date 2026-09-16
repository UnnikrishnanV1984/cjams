/*
-- CJAMS-69338 - Duplicate Investigation Findings
 -- Issue Description: In this case, investigation tab is showing duplicated result
 -- Category/ Module: caseworker > investigationfindings
 -- Root cause: Two records were created.
 -- Fix Provided: Datafix has been added by deleting the record against investigation allegation id and allegation id.
 -- Pull request# N/A 
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 */
update investigationallegation
set activeflag = 0, updatedby = 'CJAMS-69338', updatedon = now()
where investigationallegationid = '6713e69a-7148-4e34-a4dd-6d75361bd928' and allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31';

update Investigationallegationmaltreators
set activeflag = 0,
    updatedby = 'CJAMS-66232',
    updatedon = now()
where investigationallegationid = '6713e69a-7148-4e34-a4dd-6d75361bd928'
and activeflag=1;
