/*
   Issue Description: CDM-24954
   Category/ Module  : Person  
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update personprogramarea set activeflag = 0, updatedby = 'CDM-24954', updatedon = now() 
where personprogramid = 'a75692f6-5f0e-4e30-a9b1-0ed0f1359604';