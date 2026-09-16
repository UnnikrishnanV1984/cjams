
/*
   Issue Description: CDM-32287
   Category/ Module  : Documents
   Fix Provided: Prod data fix to update correct inserted user details 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


--17edf464-1c8a-48a3-b494-6af008ff1cc1
--c57c1a06-d7f0-4a6d-b61d-e8289d326001

 update documentproperties set insertedby = '0d8c6f3d-407f-4b03-a70f-d1e4e8bdb62a', updatedby = 'CDM-32287' 
where documentpropertiesid in ('3957c1bb-f2e3-4bff-b1c5-47b2013a8fb5','920b0f7a-1f12-487d-ae01-344dd6cafa8d');

 --17edf464-1c8a-48a3-b494-6af008ff1cc1
--c57c1a06-d7f0-4a6d-b61d-e8289d326001
  update documentattachment set insertedby = '0d8c6f3d-407f-4b03-a70f-d1e4e8bdb62a', updatedby = 'CDM-32287' 
where documentpropertiesid in ('3957c1bb-f2e3-4bff-b1c5-47b2013a8fb5','920b0f7a-1f12-487d-ae01-344dd6cafa8d');