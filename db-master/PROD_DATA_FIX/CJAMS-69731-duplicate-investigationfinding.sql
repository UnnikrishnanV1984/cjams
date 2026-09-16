/*
   Issue Description: CJAMS-69731
   Category/ Module: Investigation finding
   Root cause: User requested to remove the duplicate investigation findings
   Fix Provided: As requested data fix has been provided by deleting the duplicate investigation findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   need to do data fix
*/


update investigationallegation
set activeflag=0, updatedby='CJAMS-69731', updatedon=now()
where investigationallegationid='b5a0d300-9a3a-45f8-b3e9-4d61949742d7' and allegationid='e11fc4b5-1edf-4f17-af54-b536bbf6df31'and activeflag=1;