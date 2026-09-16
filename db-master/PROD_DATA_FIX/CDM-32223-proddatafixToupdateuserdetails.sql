/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 3ce63124-3e7d-4da3-a3f0-4d34f1a36824
  update documentproperties set insertedby = 'fce1bb83-a66c-4500-aa07-f26fd919f931', updatedby = 'CDM-32223' 
  where documentpropertiesid = 'a89f971c-ca8d-4218-9930-a3ba55d0f6a2';


-- 3ce63124-3e7d-4da3-a3f0-4d34f1a36824
  update documentattachment set insertedby = 'fce1bb83-a66c-4500-aa07-f26fd919f931', updatedby = 'CDM-32223' 
  where documentpropertiesid = 'a89f971c-ca8d-4218-9930-a3ba55d0f6a2';

