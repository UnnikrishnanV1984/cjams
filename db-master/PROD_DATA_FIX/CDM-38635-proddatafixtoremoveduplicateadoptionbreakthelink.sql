/*
   Issue Description: CDM-38635
   Category/ Module  : Prod data fix to remove duplicate adoption break the link
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update adoptionbreakthelink set activeflag = 0, updatedby = 'CDM-38635', updatedon = now()
where adoptionbreakthelinkid = 'a6ed3916-0230-402a-9393-1431f0a9cc1e' and activeflag = 1;