/*
  Issue Description:  CDM-42115
   Category/ Module  :  Application
   Root cause: User request to remove CPS/AR
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update personprogramarea set activeflag = 0, updatedby = 'CDM-42115', updatedon = now()
where personprogramid in('57f5cc07-d8b7-47e6-84ee-31de4264c6e4', 'b86636d4-273b-44ba-9558-4f0b4a40d898', 'def8883e-5ae4-4826-8f8e-6c8d22dc223f', '140b731a-8764-4713-bdb1-deac5d70efd8')
and activeflag = 1;