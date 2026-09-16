/*
   Issue Description: CDM-15956
   Category/ Module  : Program assignment
   Root cause: user wants to remove a enddate for program assignment
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update personprogramarea set enddate = null, updatedby = 'CDM-15956', updatedon = now() 
where personprogramid = '5354f471-0350-4c73-a21d-a44d5585ff8d';