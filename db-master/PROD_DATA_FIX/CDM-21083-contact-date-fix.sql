/*
  Issue Description: CDM-21083 - incorrect contact date
   Category/ Module  :  child welfare
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   data fix issue, 
   Backup before update/ delete:
*/

update cjams.progressnote set contactdate = '2022-02-24T00:00:00', updatedby = 'CIDM-21083', updatedon = now()
where progressnoteid  = 'b95ab00a-b26c-4231-8d18-0dbbdc9d5545';
