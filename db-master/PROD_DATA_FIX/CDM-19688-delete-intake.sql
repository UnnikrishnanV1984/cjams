/*
   Issue Description: CDM-19688
   Category/ Module  : Remove intake
   Root cause: user requeseted to remove intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-19688'
where objectid = 'I202000495671';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-19688'
where intakenumber = 'I202000495671';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-19688'
where intakenumber = 'I202000495671';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-19688'
where intakenumber = 'I202000495671';