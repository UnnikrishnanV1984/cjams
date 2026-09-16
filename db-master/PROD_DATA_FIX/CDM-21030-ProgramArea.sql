/*
   Issue Description: CDM-21030
   Category/ Module  : Program area 
   Root cause: user wants update the program area person
   Pull request# for code fix: 4979
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update personprogramarea set updatedby = '4d98a0c2-3006-4687-914a-72ae28497f68', updatedon = now()
where personprogramid = '2c1c183c-c002-4ef0-9333-41b26f6cd408';