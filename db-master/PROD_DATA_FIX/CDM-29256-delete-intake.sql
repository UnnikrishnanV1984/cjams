/*
   Issue Description: CDM-29256
   Category/ Module  : Delete intake
   Root cause: user wants to delete intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29256'
where objectid = 'I231010516778';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29256'
where intakenumber = 'I231010516778';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29256'
where intakenumber = 'I231010516778';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29256'
where intakenumber = 'I231010516778';