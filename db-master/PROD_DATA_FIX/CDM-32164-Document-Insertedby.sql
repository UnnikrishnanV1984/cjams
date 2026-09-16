 
/*
   Issue Description: CDM-32164
   Category/ Module  : Prod data fix to update correct inserted user details 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
-- fbd90a98-e840-4c32-8fd9-55f94384da21    JessicaBeall    1bce6a8d-084b-4529-b830-ca03f29fb0e6
-- 81652d66-3885-4983-a438-dd1fa7ad9072    JessicaBeall    3227c406-8aa1-4c59-80bd-61c9d222f151
-- fbd90a98-e840-4c32-8fd9-55f94384da21    JessicaBeall    770ca31c-0234-4453-9430-e868a9758609	
 
 
 update documentproperties set insertedby = 'fbd90a98-e840-4c32-8fd9-55f94384da21', updatedby = 'CDM-32164', updatedon = now()
where documentpropertiesid in 
('3227c406-8aa1-4c59-80bd-61c9d222f151','770ca31c-0234-4453-9430-e868a9758609','1bce6a8d-084b-4529-b830-ca03f29fb0e6');	

update documentattachment 
set insertedby = 'fbd90a98-e840-4c32-8fd9-55f94384da21', updatedby = 'CDM-32164', updatedon = now()
where documentpropertiesid in 
('3227c406-8aa1-4c59-80bd-61c9d222f151','770ca31c-0234-4453-9430-e868a9758609','1bce6a8d-084b-4529-b830-ca03f29fb0e6');	