/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- a4826309-94e9-4680-96bf-eeec3962b46a
  update documentproperties set insertedby = 'bd26ba51-e656-49f6-b9a6-3f5e6a38480e', updatedby = 'CDM-32158' 
  where documentpropertiesid = '2ca72055-7d62-4f4d-a8c3-1032e97c4d9a';
  

  -- a4826309-94e9-4680-96bf-eeec3962b46a
  update documentattachment set insertedby = 'bd26ba51-e656-49f6-b9a6-3f5e6a38480e', updatedby = 'CDM-32158' 
  where documentpropertiesid = '2ca72055-7d62-4f4d-a8c3-1032e97c4d9a';
  