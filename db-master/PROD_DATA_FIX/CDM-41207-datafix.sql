/*
  Issue Description: CDM-41207
   Category/ Module  :  
   Root cause: User request to Data fix to remove the AR summary 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update     Investigationmaltreatment
set     activeflag = 0,
        updatedby = 'CDM-41207',
        updatedon = now()
where     maltreatmentid = '7d17b7eb-bf92-49c8-aebd-64cf1ddaf466';