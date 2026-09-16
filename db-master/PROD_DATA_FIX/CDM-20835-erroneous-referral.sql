/*
   Issue Description: CDM-20835
   Category/ Module  : delete intake
   Root cause: user wants to delete intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-20835'
where objectid = 'I221010238462';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-20835'
where intakenumber = 'I221010238462';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-20835'
where intakenumber = 'I221010238462';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-20835'
where intakenumber = 'I221010238462';