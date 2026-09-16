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



update permanencyplan set activeflag = 0,updatedby = 'CDM-31051', updatedon =now() where permanencyplanid in('a37777a1-763e-4b40-9553-0a12bf96ca35','3e05b586-5a4b-47f4-9b6e-e7979152c254');