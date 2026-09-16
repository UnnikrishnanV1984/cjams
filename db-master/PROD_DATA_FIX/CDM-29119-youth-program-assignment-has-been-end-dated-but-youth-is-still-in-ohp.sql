
/*
   Issue Description: CDM-29119
   Category/ Module  :Removing person program end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    personprogramarea p
set
    enddate = null,
    updatedby = 'CDM-29119',
    updatedon = now()
where
    personprogramid = '84750a7f-0cde-4a5e-9750-725ae28bb595';