/*
   Issue Description: CDM-32072
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




--040da3c2-849f-4816-9bd5-febc0649e170
--a9022e7e-027d-4d7c-a41f-a0183817e0e4
update documentproperties set insertedby = '0e812c87-2a0c-422c-881a-be126c370cd5', updatedby = 'CDM-32072', updatedon = now()
where documentpropertiesid in ('774a6090-ecc1-4041-af09-f4661c498985','acce9612-0d26-44d8-a298-be132358c584');

--040da3c2-849f-4816-9bd5-febc0649e170
--a9022e7e-027d-4d7c-a41f-a0183817e0e4
update documentattachment set insertedby = '0e812c87-2a0c-422c-881a-be126c370cd5', updatedby = 'CDM-32072', updatedon = now()
where documentpropertiesid in ('774a6090-ecc1-4041-af09-f4661c498985','acce9612-0d26-44d8-a298-be132358c584');
