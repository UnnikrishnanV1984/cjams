 
/*
   Issue Description:CDM-25371
   Category/ Module  : Documents  
   Root cause: user error
   Reason why no related code fix: web fix already raised 
*/


-- Checked documentattachment as welll 

update cjams.documentproperties set activeflag =1, updatedby='CDM-25371', updatedon = now()

where documentpropertiesid='5ea955aa-9b21-4a50-8e3d-f838b771df03';