/*
   Issue Description: CDM-15376
   Category/ Module  :  Case removal
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update personprogramarea set enddate = null, updatedby = 'CDM-15376', updatedon = now() 
where personprogramid = 'f0888ae3-d483-44cb-97ca-4919417b69fd';