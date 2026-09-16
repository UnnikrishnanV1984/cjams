/*
  Issue Description: CDM-42505
  Root cause: User request 
  Fix Provided: Supervisory staff are not showing correctly on case banner.

*/

update userprofile
  set updatedby='CDM-42505', updatedon=now(), supervisorid='e1afd4ef-a333-4e96-9f76-e118fdc13cc8'
  where securityusersid='5480f24f-aa6d-42f9-89e4-aa89d4d92c29' and activeflag=1;

update userprofile
  set updatedby='CDM-42505', updatedon=now(), supervisorid='e1afd4ef-a333-4e96-9f76-e118fdc13cc8'
  where securityusersid='f00beb28-695b-445f-ba51-8884665840e5' and activeflag=1;

update userprofile
  set updatedby='CDM-42505', updatedon=now(), supervisorid='e1afd4ef-a333-4e96-9f76-e118fdc13cc8'
  where securityusersid='20714b3a-a615-40cd-bac5-eb836a5ab90f' and activeflag=1;