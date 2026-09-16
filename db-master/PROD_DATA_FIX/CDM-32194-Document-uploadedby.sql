/*
   Issue Description: CDM-32194
   Category/ Module  : Prod data fix to update correct inserted user details 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/ 

-- ef09e223-ee64-46f1-a6b1-c1526029a35f    0d234494-ffba-45fb-84f9-e8b108ad64b4    73edbae9-6621-4a87-8c45-e42e9b52cadb
-- 01fe8c8a-99b7-464b-8ae7-25ed14483d8e    0d234494-ffba-45fb-84f9-e8b108ad64b4    f0ecd42e-880a-45ae-b577-ee47c70f824a
-- 7958f08e-5056-43d7-a970-cc2972994ab2    7958f08e-5056-43d7-a970-cc2972994ab2    ff0c61c8-1025-46f3-ba1b-29fe372c6893

update documentproperties set insertedby = '0d234494-ffba-45fb-84f9-e8b108ad64b4', updatedby = 'CDM-32194', updatedon = now()
where documentpropertiesid in ('ff0c61c8-1025-46f3-ba1b-29fe372c6893','73edbae9-6621-4a87-8c45-e42e9b52cadb','f0ecd42e-880a-45ae-b577-ee47c70f824a');  

 update documentattachment 
 set insertedby = '0d234494-ffba-45fb-84f9-e8b108ad64b4', updatedby = 'CDM-32194', updatedon = now()
where documentpropertiesid in ('ff0c61c8-1025-46f3-ba1b-29fe372c6893','73edbae9-6621-4a87-8c45-e42e9b52cadb','f0ecd42e-880a-45ae-b577-ee47c70f824a');  
