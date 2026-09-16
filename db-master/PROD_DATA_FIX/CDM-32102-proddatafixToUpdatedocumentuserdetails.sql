/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


--CDM-32102
--01fe8c8a-99b7-464b-8ae7-25ed14483d8e
--ef09e223-ee64-46f1-a6b1-c1526029a35f
--0d234494-ffba-45fb-84f9-e8b108ad64b4
--9ca9a597-fd93-43e7-b5e7-1b32d4a8c56f
 update documentproperties set insertedby = '0d234494-ffba-45fb-84f9-e8b108ad64b4', updatedby = 'CDM-32102'
where documentpropertiesid in ('f0ecd42e-880a-45ae-b577-ee47c70f824a',
'73edbae9-6621-4a87-8c45-e42e9b52cadb',
'a4e95bfb-1d53-4d7e-9478-63fff32796f5',
'251a4102-8bbc-48a9-a6b1-531d4d9b6f93');


--CDM-32102
--01fe8c8a-99b7-464b-8ae7-25ed14483d8e
--ef09e223-ee64-46f1-a6b1-c1526029a35f
--0d234494-ffba-45fb-84f9-e8b108ad64b4
--9ca9a597-fd93-43e7-b5e7-1b32d4a8c56f
 update documentattachment set insertedby = '0d234494-ffba-45fb-84f9-e8b108ad64b4', updatedby = 'CDM-32102'
where documentpropertiesid in ('f0ecd42e-880a-45ae-b577-ee47c70f824a',
'73edbae9-6621-4a87-8c45-e42e9b52cadb',
'a4e95bfb-1d53-4d7e-9478-63fff32796f5',
'251a4102-8bbc-48a9-a6b1-531d4d9b6f93');

