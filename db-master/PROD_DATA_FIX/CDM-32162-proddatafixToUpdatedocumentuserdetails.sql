/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/







-- CDM-32162
--07a546d5-9823-49d4-9167-5228b43e47d1
 update documentproperties set insertedby = '2b3bca8d-33ce-48db-ab92-3e0b2447d234', updatedby = 'CDM-32152', updatedon = now()
where documentpropertiesid in ('24f5c9ab-8082-41fb-a7f8-df95f262f33a');


--07a546d5-9823-49d4-9167-5228b43e47d1
 update documentattachment set insertedby = '2b3bca8d-33ce-48db-ab92-3e0b2447d234', updatedby = 'CDM-32152', updatedon = now()
where documentpropertiesid in ('24f5c9ab-8082-41fb-a7f8-df95f262f33a');


