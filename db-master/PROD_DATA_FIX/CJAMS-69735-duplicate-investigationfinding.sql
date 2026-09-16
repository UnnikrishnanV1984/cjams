/*
   Issue Description: CJAMS-69735
   Category/ Module: Investigation finding
   Root cause: User requested to remove the duplicate investigation findings
   Fix Provided: As requested data fix has been provided by deleting the duplicate investigation findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   need to do data fix
*/


update investigationallegation
set activeflag=0, updatedby='CJAMS-69735', updatedon=now()
where investigationallegationid='2b8f908a-0823-4103-b15a-74cfb6e3c122' and investigationid='b4428e74-c803-47f7-8466-30cdb98a1567' and activeflag=1;