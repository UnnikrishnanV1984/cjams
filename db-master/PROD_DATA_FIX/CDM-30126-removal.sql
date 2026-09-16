/*
   Issue Description: CDM-30126
   Category/ Module  : program assignments
   Root cause: user requeseted to remove record from program assignment 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: data fix
*/
update
    personprogramarea
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30126'
where
    personprogramid = '11ef3e2c-50ee-4a88-9546-7703f2db8c14';