/*
   Issue Description: CJAMS-59333
   Category/ Module  : person program area
   Root cause: OOH enddate Needs to be removed.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update personprogramarea
set updatedby='CJAMS-59333', updatedon=now(), enddate= '2024-12-11 00:00:00.000'
where personprogramid='dd5370b7-ce81-4056-9d43-26fa41656140' and personid='c12632d2-e5be-4ebd-8b2e-42493780f62a';