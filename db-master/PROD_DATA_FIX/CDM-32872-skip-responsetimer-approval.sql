/*
   Issue Description: CDM-32872
   Category/ Module  :Dashboard
   Root cause: cps response timer skip request peding approval. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing set activeflag = 0,updatedby ='CDM-32872',updatedon =now() where routingid in ('6a29c56c-aa35-4cfe-b7af-7adb243f65df','b3e112cc-fcf6-42d9-a804-1dc39630dcfc','2c49716e-c128-48fd-91aa-8d548e41db96','63782ca7-31c1-4b3d-a566-68128b993017');