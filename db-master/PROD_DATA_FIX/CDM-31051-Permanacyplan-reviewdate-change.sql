/*
   Issue Description: CDM-31051
   Category/ Module  :Permanency plan
   Root cause: wrong plan review date 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update permanencyplan set reviewdate ='2022-11-06 04:00:00',updatedby = 'CDM-31051',updatedon = now() where permanencyplanid = '0d4d9482-85de-4624-b1f9-7f749c2520e1';