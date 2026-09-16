/*
   Issue Description: CDM-39131
   Category/ Module  : Assignments
   Root cause: Remove the intake as requested as the worker created the intake by error.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


UPDATE intakedastaging  SET activeflag=0, updatedby='CDM-39131', updatedon=now()
 where intakenumber='I241012098321';

UPDATE intakedastatus SET activeflag=0, updatedby='CDM-39131', updatedon=now() 
where intakenumber='I241012098321'; 