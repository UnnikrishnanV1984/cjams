/*
   Issue Description: CDM-32069
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- 5c1f57ce-a319-4afe-a93d-3dfb4e3bee5c
update documentproperties set insertedby = 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', updatedby = 'CDM-32069', updatedon = now()
where documentpropertiesid = '49deb793-0f02-45e2-b2ba-fe3fdb5d01e3';




-- 5c1f57ce-a319-4afe-a93d-3dfb4e3bee5c
update documentattachment set insertedby = 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', updatedby = 'CDM-32069', updatedon = now()
where documentpropertiesid = '49deb793-0f02-45e2-b2ba-fe3fdb5d01e3';

