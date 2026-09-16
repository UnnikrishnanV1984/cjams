/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


--e4bcec66-b8ef-476f-915c-375f6c71a5d1
--f156b6d0-67af-404f-bf79-d4fbd737716c
  update documentproperties set insertedby = '9d0ab8f6-81a3-41a2-b80f-7d22e4ac1da7', updatedby = 'CDM-32236' 
  where documentpropertiesid in ('f719044a-35be-4b32-8b21-5b402612a1ab',
'10e9da84-620d-46cb-b542-c42b97b8d350');



--e4bcec66-b8ef-476f-915c-375f6c71a5d1
--f156b6d0-67af-404f-bf79-d4fbd737716c
  update documentattachment set insertedby = '9d0ab8f6-81a3-41a2-b80f-7d22e4ac1da7', updatedby = 'CDM-32236' 
  where documentpropertiesid in ('f719044a-35be-4b32-8b21-5b402612a1ab',
'10e9da84-620d-46cb-b542-c42b97b8d350');