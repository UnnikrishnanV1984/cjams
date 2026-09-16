/*
  Issue Description:  CDM-38230
   Category/ Module  :  Program Info 
   Root cause: User Unable to end date the CPS program assignments to close the case.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

Update personprogramarea
set enddate= '2023-01-04 16:24:00', updatedon= now(), updatedby='CDM-38230'
where personprogramid in (
'd8405b49-f011-4910-9822-4ca13c7fe081','3248a45c-f4b8-4923-bc7d-41b5e3c0420f',
'27c6d3c8-9fcc-4b55-b6e9-85b27c52c8de','3fff6568-f24d-40e5-8fca-fbf8e3b1be33');

Update personprogramarea
set enddate= '2010-03-08 10:45:00', updatedon= now(), updatedby='CDM-38230'
where personprogramid in ('6652fa02-d314-42fb-8b7b-be1e8c8071ad',
'000954c8-1d1a-4313-9bec-83a6c3f8785e','7567f067-6ea4-46a2-8c55-ebf68926acb6',
'41c314c0-a767-47d3-95a1-1758af19cf22','8674ddb9-ba52-4275-8f77-97651a9b3451');