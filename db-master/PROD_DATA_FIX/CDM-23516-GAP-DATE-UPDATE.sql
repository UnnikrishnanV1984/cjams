/*
   Issue Description: CDM-23516
   Category/ Module  : Person - Program area  
   Root cause: User wants to remove the GAP end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update personprogramarea set enddate = null , updatedby = 'CDM-23516', updatedon  = now() 
where personprogramid in ('660c17d7-23f6-4eeb-9927-2bce1e515fb4','9eebd6b3-5812-4f76-a1be-9cdd9b17ba66') and activeflag = 1;