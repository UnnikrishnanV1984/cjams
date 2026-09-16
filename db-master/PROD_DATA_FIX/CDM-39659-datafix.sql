/* 
    Issue Description: CDM-39652
  Category/ Module  : 
  Root cause: User request to delete Program Assignment Parent of child in out of home care. 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/


update personprogramarea set activeflag = 0, updatedby = 'CDM-39652', updatedon = now()  where personprogramid = '6008fbe4-cc8a-4c3f-acbc-cbd8aa77fe1e'
and personid='8c6091ad-322e-4163-aa32-45b63b0225ee' and activeflag=1;