	/*
   Issue Description: CDM-29219
   Category/ Module  : service case disposition
   Root cause: user wants to remove duplicate
   Pull request# for code fix: 
   Reason why no related code fix: 
    */


update
    servicecasedisposition
set
    activeflag = 0,
    updatedby = 'CDM-29219',
    updatedon = now()
where
    servicecasedispositionid = '559abf88-c855-480c-a5a5-b82c48335253';