/*
   Issue Description: CDM-19695
   Category/ Module  : Approval screen
   Root cause: user asked to remove
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing 
set activeflag = 0, updatedby = 'CDM-19695', updatedon = now()
where routingid in ('ad6fe816-5a3d-4254-89d9-a74fb425d048', '6c75be19-3b64-4d4c-b57d-fdd37f93dc16','7c4ecb6f-e8e2-40bc-8a56-e9fac1b3cca0');
