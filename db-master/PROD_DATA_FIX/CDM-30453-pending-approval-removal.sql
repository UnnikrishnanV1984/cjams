/*
   Issue Description: CDM-30453
   Category/ Module  : Dashboard
   Root cause: user requested to remove pending approval from dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    
*/

update
   routing 
set 
  activeflag = 0,
  updatedby = 'CDM-30453' ,
  updatedon = now() 
 where 
  objectid in ('89ad35ca-3185-4cb9-bcc2-09cc68bcf387','cf7f43d1-ecb2-46cb-9ca0-64ed8c7e842a');