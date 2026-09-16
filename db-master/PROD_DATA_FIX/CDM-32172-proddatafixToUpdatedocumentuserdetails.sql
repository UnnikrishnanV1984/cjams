/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- CDM-32172
-- d5ccb914-fc10-4cfc-a709-aa98f9228b66 
update documentproperties set insertedby = '669f5972-d784-44ee-8dbd-00a013e444da', updatedby = 'CDM-32172', updatedon = now()
where documentpropertiesid = '2d9caaca-9268-4a81-9b82-645280f5e2ee';


-- 07a546d5-9823-49d4-9167-5228b43e47d1
update documentproperties set insertedby = '669f5972-d784-44ee-8dbd-00a013e444da', updatedby = 'CDM-32172', updatedon = now()
where documentpropertiesid = 'c5a38a30-c6b1-4625-9e28-b14fffd5ca2a';



-- d5ccb914-fc10-4cfc-a709-aa98f9228b66 
update documentattachment set insertedby = '669f5972-d784-44ee-8dbd-00a013e444da', updatedby = 'CDM-32172', updatedon = now()
where documentpropertiesid = '2d9caaca-9268-4a81-9b82-645280f5e2ee';


-- 07a546d5-9823-49d4-9167-5228b43e47d1
update documentattachment set insertedby = '669f5972-d784-44ee-8dbd-00a013e444da', updatedby = 'CDM-32172', updatedon = now()
where documentpropertiesid = 'c5a38a30-c6b1-4625-9e28-b14fffd5ca2a';


