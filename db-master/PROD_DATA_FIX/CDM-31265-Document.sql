/*
   Issue Description: CDM-31265
   Category/ Module  : Documents  
   Root cause: user requested
   Reason why no related code fix: web fix already raised 
*/

update cjams.documentproperties set activeflag =0, updatedby ='CDM-31265',updatedon = now()
where documentpropertiesid in ('19ca0d51-dbd8-426f-b515-c1626a26c367');

update cjams.documentattachment set activeflag =0, updatedby ='CDM-31265',updatedon = now()
where documentpropertiesid in ('19ca0d51-dbd8-426f-b515-c1626a26c367');