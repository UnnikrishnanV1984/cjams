/* 
    Issue Description: CDM-39009
  Category/ Module  : Assessments: Other
  Root cause: removed the APPLA review request from the supervisor (Jessica Savage) assessment pending approval dashboard.
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

update routing 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39009'
    where routingid = '67f26174-b145-45d5-9731-7fd58234fc04'
        and activeflag = 1 and eventcode ='ASST';
    
update routing 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39009'
    where routingid = '5f197f82-55f5-4400-9510-7d3b13db6305'
        and activeflag = 1 and eventcode ='ASST';