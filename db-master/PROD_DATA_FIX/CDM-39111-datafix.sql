/* 
    Issue Description: CDM-39111
  Category/ Module  : Services: Service Log
  Root cause: User request to update the start date
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

update serviceplan set effectivedate='2024-02-09 10:00:00.000',updatedby='CDM-39111',updatedon=now()
where serviceplanid ='7da93b99-d145-4fd4-8d29-729b6546b2d0';