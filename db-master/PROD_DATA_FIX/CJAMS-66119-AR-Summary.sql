/*
  Issue Description: CJAMS-66119
   Category/ Module  :  
   Root cause: User request to Data fix to remove the AR summary 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update
    investigationallegation
set
    activeflag = 0,
    updatedby = 'CJAMS-66119',
    updatedon = now()
where
    investigationallegationid = '406acf01-2fe0-4118-aee5-49ae40e0e365'
    and allegationid = '2482ea5f-2cfa-434c-b2e7-e0501371b961' and activeflag = 1;
   
  
   
   