/*
   Issue Description: CJAMS-68758
   Category/ Module  :  Traditional Candidacy List
   Root cause: Supervisor approval date.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update serviceplan 
set enddate = null , updatedby = 'CJAMS-68758', updatedon = now()
  where serviceplanid = 'c77d59c0-7233-48c9-9314-a79533dd342b' and activeflag = 1;