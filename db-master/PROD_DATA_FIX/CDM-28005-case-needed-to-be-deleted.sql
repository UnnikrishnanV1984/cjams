/*
   Issue Description: CDM-28005
   Category/ Module  : delete intake 
   Root cause: user wants to delete intake
   Pull request# for code fix: 6911
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28005'
where objectid = 'I221010351226';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28005'
where intakenumber = 'I221010351226';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28005'
where intakenumber = 'I221010351226';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28005'
where intakenumber = 'I221010351226';


update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28005'
where objectid = 'I221010351048';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28005'
where intakenumber = 'I221010351048';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28005'
where intakenumber = 'I221010351048';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28005'
where intakenumber = 'I221010351048';