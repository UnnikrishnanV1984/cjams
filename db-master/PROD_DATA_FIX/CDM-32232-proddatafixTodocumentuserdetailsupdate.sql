/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 3a8d26c3-7bba-4131-acba-34f899b1602e
  update documentproperties set insertedby = 'b66338ae-a2dc-425d-a59a-f4e7a1d5d704', updatedby = 'CDM-32235' 
  where documentpropertiesid = 'bc3309fb-d608-4b28-bc55-7b5f6e4bee64';

-- 3a8d26c3-7bba-4131-acba-34f899b1602e
  update documentattachment set insertedby = 'b66338ae-a2dc-425d-a59a-f4e7a1d5d704', updatedby = 'CDM-32235' 
  where documentpropertiesid = 'bc3309fb-d608-4b28-bc55-7b5f6e4bee64';
