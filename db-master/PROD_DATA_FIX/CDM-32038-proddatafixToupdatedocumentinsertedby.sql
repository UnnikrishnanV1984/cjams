/*
   Issue Description: CDM-32038
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- d226dcf0-121b-4ddf-88d9-cfa397e4d1ee
update documentproperties set insertedby = 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', updatedby = 'CDM-32038', updatedon = now()
where documentpropertiesid = '10b5143d-7571-4175-bec9-d9d04be96e44';


-- d226dcf0-121b-4ddf-88d9-cfa397e4d1ee
update documentattachment set insertedby = 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', updatedby = 'CDM-32038', updatedon = now()
where documentpropertiesid = '10b5143d-7571-4175-bec9-d9d04be96e44';
