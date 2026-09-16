/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/







-- CDM-32165
--dca1e216-73df-4fe5-9e24-aae5d37bffda
 update documentproperties set insertedby = 'ecbae51c-ea05-4f05-bd78-67461d1b7e64', updatedby = 'CDM-32165', updatedon = now()
where documentpropertiesid in ('69986f05-82bd-4856-ba35-931b2b7eca2b');


--dca1e216-73df-4fe5-9e24-aae5d37bffda
 update documentattachment set insertedby = 'ecbae51c-ea05-4f05-bd78-67461d1b7e64', updatedby = 'CDM-32165', updatedon = now()
where documentpropertiesid in ('69986f05-82bd-4856-ba35-931b2b7eca2b');

