/*
   Issue Description: CDM-25422
   Category/ Module  : Case assignment Removal 
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4718
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


update routing set activeflag = 0, updatedby = 'CDM-25422', 
updatedon = now() where objectid = '3322af8d-d122-41f1-9135-6a5a879f7cd2';

update routing set activeflag = 0, updatedby = 'CDM-25422', 
updatedon = now() where objectid = '3322af8d-d122-41f1-9135-6a5a879f7cd2';

update routing set activeflag = 0, updatedby = 'CDM-25422', 
updatedon = now() where objectid = 'b72bfcdb-a4a6-4b54-8b6b-5daff2198a2f';






