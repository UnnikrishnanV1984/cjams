/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- CDM-32127
--5e825b28-000f-4183-bdc4-f6ad2e5138bd
 update documentproperties set insertedby = 'e4b5f055-b967-4b2b-9f44-04d76dbcc2d7', updatedby = 'CDM-32127' 
where documentpropertiesid in ('24eb48c9-2ccb-4901-a758-da6d07933dce');


   -- 5e825b28-000f-4183-bdc4-f6ad2e5138bd
  update documentattachment set insertedby = 'e4b5f055-b967-4b2b-9f44-04d76dbcc2d7', updatedby = 'CDM-32127' 
  where documentpropertiesid = '24eb48c9-2ccb-4901-a758-da6d07933dce';
  
  