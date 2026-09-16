/*
   Issue Description: CDM-34394
   Category/ Module  : inatke delete
   Root cause: user wants to delete intake as it was created in error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34394'
where objectid = 'I231010399602' and activeflag = 1;

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34394'
where intakenumber = 'I231010399602' and activeflag = 1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34394'
where intakenumber = 'I231010399602' and activeflag = 1;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34394'
where intakenumber = 'I231010399602' and activeflag = 1;