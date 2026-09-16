/*
   Issue Description: CDM-21825
   Category/ Module: assignments tab
   Root cause: user wants to assign case to appeal coordinator
   Pull request# for code fix:6651
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update intakeservicerequest 
        set isrouted = true,
            updatedby = 'CDM-21825',
            updatedon = now()
        where intakeserviceid = 'df841b9a-6a9d-4c43-8b5f-786086235c0b';