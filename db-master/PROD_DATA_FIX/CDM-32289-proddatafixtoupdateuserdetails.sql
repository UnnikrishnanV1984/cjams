/*
   Issue Description: CDM-32289
   Category/ Module  : Documents
   Fix Provided: Prod data fix to update correct inserted user details 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


--6d1a76e4-ec51-4eed-a40d-847bb3a3b4f9
 update documentproperties set insertedby = '0d8c6f3d-407f-4b03-a70f-d1e4e8bdb62a', updatedby = 'CDM-32289' 
where documentpropertiesid in ('725a4b97-d672-445c-bfbd-cd4376f506cd');


   -- 6d1a76e4-ec51-4eed-a40d-847bb3a3b4f9
  update documentattachment set insertedby = '0d8c6f3d-407f-4b03-a70f-d1e4e8bdb62a', updatedby = 'CDM-32289' 
  where documentpropertiesid = '725a4b97-d672-445c-bfbd-cd4376f506cd';