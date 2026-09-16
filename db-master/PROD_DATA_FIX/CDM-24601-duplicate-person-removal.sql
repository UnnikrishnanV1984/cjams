/*
   Issue Description: CDM-24601
   Category/ Module  : duplicate person removal  
   Root cause: User requested to remove duplicate person from case
   Pull request# for code fix: 7508
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update personrole set activeflag = 0 ,
updatedon = now(),
updatedby = 'CDM-24601'
where personroleid = 'ed129900-b95d-478e-9a00-20d8dfc40681';