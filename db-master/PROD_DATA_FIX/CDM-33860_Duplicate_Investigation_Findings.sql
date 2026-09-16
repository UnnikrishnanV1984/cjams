-- CDM-33860 - Duplicate Investigation Findings
/*
 -- Issue Description: In this case, investigation tab is showing duplicated result
 -- Category/ Module: caseworker > investigationfindings
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
    updatedby = 'CDM-33860',
    updatedon = now()
where
    investigationallegationid = 'a3b9b03b-b458-4f04-8a01-887d98dd30f1'
    and allegationid = 'e54563a4-b41c-4071-bfc0-fc3d33a052f5';