/*
   Issue Description: CDM-28569
   Category/ Module  : Intake
   Root cause: user wants to delete intake from CJAMS
   Pull request# for data fix:8005
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28569'
where objectid = 'I231010406873';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28569'
where intakenumber = 'I231010406873';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28569'
where intakenumber = 'I231010406873';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28569'
where intakenumber = 'I231010406873';