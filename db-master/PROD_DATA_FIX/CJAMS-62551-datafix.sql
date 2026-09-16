/*
   Issue Description: CJAMS-62551
   Category/ Module  : delete intake I251013338559
   Root cause: user wants to delete intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-62551'
where intakenumber = 'I251013338559';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-62551'
where intakenumber = 'I251013338559';