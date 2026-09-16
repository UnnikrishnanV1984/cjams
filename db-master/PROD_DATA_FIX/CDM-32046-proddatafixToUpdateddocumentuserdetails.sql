/*
   Issue Description: CDM-32046
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 99a068e8-c725-4835-9aee-0712f9d4021c
update documentproperties set insertedby = '7e8941ee-bddb-4ce0-90a9-8a67a22d3165', updatedby = 'CDM-32046', updatedon = now()
where documentpropertiesid = '4d363673-9650-47f9-99e7-5fd229c29617';




-- 99a068e8-c725-4835-9aee-0712f9d4021c
update documentattachment set insertedby = '7e8941ee-bddb-4ce0-90a9-8a67a22d3165', updatedby = 'CDM-32046', updatedon = now()
where documentpropertiesid = '4d363673-9650-47f9-99e7-5fd229c29617';