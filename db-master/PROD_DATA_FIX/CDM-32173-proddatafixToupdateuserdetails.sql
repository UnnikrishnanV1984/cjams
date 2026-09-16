/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--16e6d971-4b07-49f7-8dff-fef69fcf4576
  update documentproperties set insertedby = '7d83183d-e600-4de4-bf7b-25b74b3495a7', updatedby = 'CDM-32173' 
  where documentpropertiesid in ('d4d1497e-e4bc-4d30-84b1-5fd84ae829d6');


--16e6d971-4b07-49f7-8dff-fef69fcf4576
  update documentattachment set insertedby = '7d83183d-e600-4de4-bf7b-25b74b3495a7', updatedby = 'CDM-32173' 
  where documentpropertiesid in ('d4d1497e-e4bc-4d30-84b1-5fd84ae829d6');
