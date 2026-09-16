/*
  Issue Description: CDM-16226 CJAMS units not matching team in SAILPOINT: Cleona Garfield
   Category/ Module  :  user management
   Root cause: Incorrect team in DB
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 0
*/
-- old team id : 103d8f83-f6b6-4023-8c5b-82129548cce8
update teammember 
set teamid = '798cce4e-f5fb-4180-9c47-228b95f525cf',updatedon = now(), updatedby ='CDM-16226'
where teammemberid='39e0e1a8-789d-4048-8b6a-294c2503f2fd';

-- old team id : 66d26714-1b71-47e1-a8b2-3f02ce51e437
update teammember 
set teamid = '798cce4e-f5fb-4180-9c47-228b95f525cf',updatedon = now(), updatedby ='CDM-16226'
where teammemberid='5f2f975c-2551-4c24-bdc7-3dd106b9f580';