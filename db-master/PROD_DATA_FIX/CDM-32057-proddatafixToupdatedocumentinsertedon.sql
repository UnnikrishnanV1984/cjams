/*
   Issue Description: CDM-32057
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- a9022e7e-027d-4d7c-a41f-a0183817e0e4
update documentproperties set insertedby = '0e812c87-2a0c-422c-881a-be126c370cd5', updatedby = 'CDM-32057', updatedon = now()
where documentpropertiesid = 'acce9612-0d26-44d8-a298-be132358c584';


-- a9022e7e-027d-4d7c-a41f-a0183817e0e4
update documentattachment set insertedby = '0e812c87-2a0c-422c-881a-be126c370cd5', updatedby = 'CDM-32057', updatedon = now()
where documentpropertiesid = 'acce9612-0d26-44d8-a298-be132358c584';

