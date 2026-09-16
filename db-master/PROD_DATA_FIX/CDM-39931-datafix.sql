/* 
  Issue Description: CDM-39931
  Category/ Module  : Placement
  Root cause: User error to remove the Unknown race
  Pull request# for code fix: 
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update person set racetypekey = '[{"racetypekey":"WH"}]', updatedby = 'CDM-39931' , updatedon = now() 
where personid = 'c55838f5-783b-4c25-ac18-ab91e79debf4';    
update personracetypemap set activeflag = 0, updatedby = 'CDM-39931' , updatedon = now() 
where personid = 'c55838f5-783b-4c25-ac18-ab91e79debf4' and racetypekey ='UN' and activeflag=1;

