/*
   Issue Description: CDM-27628
   Category/ Module  :  remove intake
   Root cause: user asked to remove intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-27628'
where objectid = 'I221010334605';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-27628'
where intakenumber = 'I221010334605';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-27628'
where intakenumber = 'I221010334605';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-27628'
where intakenumber = 'I221010334605';