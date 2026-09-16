/*
   Issue Description: CDM-29614
   Category/ Module  : Investigation Maltreatment 
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update Investigationmaltreatment 
set activeflag = 0, updatedby ='CDM-29614', updatedon = now()
where maltreatmentid in ('eed76444-d32b-4d7e-9da5-a98b7c25a2b0','ec5c9eb0-e381-4e47-b714-eb728ea24481','a729f025-d8b3-444d-ab61-1aacea18fa2d',
'6752b956-87d1-4313-81bd-1fd6ff4e3edf','7ec2bf6b-fc02-44fe-928e-b7cadb1b31a0','28c20db3-d671-40ce-ac61-5b526a7eb777','2b4b967a-82f1-4075-81f8-4f9e82c045e7');

update Investigationallegation
set activeflag = 0, updatedby ='CDM-29614', updatedon = now()
where maltreatmentid in ('eed76444-d32b-4d7e-9da5-a98b7c25a2b0','ec5c9eb0-e381-4e47-b714-eb728ea24481','a729f025-d8b3-444d-ab61-1aacea18fa2d',
'6752b956-87d1-4313-81bd-1fd6ff4e3edf','7ec2bf6b-fc02-44fe-928e-b7cadb1b31a0','28c20db3-d671-40ce-ac61-5b526a7eb777','2b4b967a-82f1-4075-81f8-4f9e82c045e7');
