/*
-- CJAMS-69339 - Duplicate Investigation Findings
 -- Issue Description: In this case, investigation tab is showing duplicated result
 -- Category/ Module: caseworker > investigationfindings
 -- Root cause: Two records were created.
 -- Fix Provided: Datafix has been added by deleting the record against investigation allegation id and allegation id.
 -- Pull request# N/A 
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 */


update investigationallegation
set activeflag = 0, updatedby = 'CJAMS-69339', updatedon = now()
where investigationallegationid in ('c23d9af0-586a-41b0-92a0-d7794459600b','6c4e3171-34c2-4cad-be6b-5df9d08a2127','70b4a9db-d126-40c6-b1c1-26b9c27c7bff','87f5c410-b269-4023-9100-2159ff6e6086','5f86668b-4275-427c-b1ce-8a9ba069f2ab','440b6c6c-1c7b-4c2b-b92d-b14cb7d6dec6','61cee2d5-f35a-4f77-a585-214a44a9af8b','177b41d3-d089-44bd-838f-62e4a3366a60','464e3a2e-0115-49c1-8e30-848be4353825','823cf442-3aeb-45a2-9a61-827b6c6931ee','052eb095-c53c-4388-b8ff-b2089583796f','6ad220fd-64ca-4ab0-a0fd-ec62328bf2a7','e3aebd9e-90cb-4bc4-a687-eb905715cc9f','bc96c07a-0a45-4a00-b177-582292c66e38','53e0d0ae-179a-4b1d-b0f3-7d04f0ca4acc','aaf6fdcf-bb7f-40d0-958a-6631ea391cd7' ) and activeflag = 1;

update investigationallegationmaltreators
set activeflag = 0, updatedby = 'CJAMS-69339', updatedon = now()
where investigationallegationid in ('c23d9af0-586a-41b0-92a0-d7794459600b','6c4e3171-34c2-4cad-be6b-5df9d08a2127','70b4a9db-d126-40c6-b1c1-26b9c27c7bff','87f5c410-b269-4023-9100-2159ff6e6086','5f86668b-4275-427c-b1ce-8a9ba069f2ab','440b6c6c-1c7b-4c2b-b92d-b14cb7d6dec6','61cee2d5-f35a-4f77-a585-214a44a9af8b','177b41d3-d089-44bd-838f-62e4a3366a60','464e3a2e-0115-49c1-8e30-848be4353825','823cf442-3aeb-45a2-9a61-827b6c6931ee','052eb095-c53c-4388-b8ff-b2089583796f','6ad220fd-64ca-4ab0-a0fd-ec62328bf2a7','e3aebd9e-90cb-4bc4-a687-eb905715cc9f','bc96c07a-0a45-4a00-b177-582292c66e38','53e0d0ae-179a-4b1d-b0f3-7d04f0ca4acc','aaf6fdcf-bb7f-40d0-958a-6631ea391cd7' ) and activeflag = 1;
