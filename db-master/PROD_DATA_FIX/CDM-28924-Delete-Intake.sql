/*
   Issue Description: CDM-28924
   Category/ Module  : Remove intake
   Root cause: user wants to delete intake
   Pull request# for code fix: 8115
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28924'
where objectid = 'I231010508582';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28924'
where intakenumber = 'I231010508582';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28924'
where intakenumber = 'I231010508582';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28924'
where intakenumber = 'I231010508582';