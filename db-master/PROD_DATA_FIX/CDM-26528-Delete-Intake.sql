/*
   Issue Description: CDM-26528
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
    updatedby = 'CDM-26528'
where objectid = 'I221010329366';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26528'
where intakenumber = 'I221010329366';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26528'
where intakenumber = 'I221010329366';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26528'
where intakenumber = 'I221010329366';