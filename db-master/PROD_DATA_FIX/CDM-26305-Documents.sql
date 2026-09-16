/*
   Issue Description: CDM-26305
   Category/ Module  : Documents  
   Root cause: user error
   Reason why no related code fix: web fix already raised 
*/

update cjams.documentproperties set activeflag =0, updatedby='CDM-26305', updatedon = now()

where documentpropertiesid in ('83abb987-88f3-4113-b858-a2c8c774ddea','19e95664-81de-444f-b35e-176987ee4d4b');


update cjams.documentattachment set activeflag =0, updatedby='CDM-26305', updatedon = now()

where documentpropertiesid in ('83abb987-88f3-4113-b858-a2c8c774ddea','19e95664-81de-444f-b35e-176987ee4d4b');