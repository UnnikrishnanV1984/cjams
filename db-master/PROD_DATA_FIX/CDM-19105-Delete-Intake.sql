/*
   Issue Description: CDM-19105
   Category/ Module  : Delete intake
   Root cause: user wants to delete intake as its a duplicate 
   Pull request# for code fix: 7258
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-19105'
where objectid = 'I211010221873';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-19105'
where intakenumber = 'I211010221873';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-19105'
where intakenumber = 'I211010221873';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-19105'
where intakenumber = 'I211010221873';