
/*
   Issue Description: CDM-31549
   Category/ Module  :personprogramarea
   Root cause: 
   Pull request# for code fix: 5821
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


update cjams.personprogramarea set enddate = null, endreasonkey = null, updatedby ='CDM-31549', updatedon = now()

where personprogramid ='cc5f412e-3f88-4d4c-9dc9-26b97b063ca5';