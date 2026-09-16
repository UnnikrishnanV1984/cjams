/*
   Issue Description: CDM-16621
   Category/ Module  :  Removing intake
   Root cause: Intake has been removed as per the user request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-16621'
where objectid = 'I202000199116';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-16621'
where intakenumber = 'I202000199116';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-16621'
where intakenumber = 'I202000199116';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-16621'
where intakenumber = 'I202000199116';