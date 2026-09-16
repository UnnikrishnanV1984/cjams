/*
   Issue Description: CDM-18337
   Category/ Module  :  remove intake
   Root cause: user asked to remove intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-19804'
where objectid = 'I221010230897';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-19804'
where intakenumber = 'I221010230897';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-19804'
where intakenumber = 'I221010230897';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-19804'
where intakenumber = 'I221010230897';