/*
   Issue Description: CJAMS-65016
   Category/ Module  : Prod data fix to remove duplicate guardianship
   Root cause:  
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/







update guardianship set activeflag = 0, updatedby = 'CJAMS-65016', updatedon= now() where gapid in ('ac5859bf-8b6a-473a-8ec8-62e4835591c5') and activeflag = 1;
