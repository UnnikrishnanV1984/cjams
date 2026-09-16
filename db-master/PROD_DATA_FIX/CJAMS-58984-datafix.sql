/*
   Issue Description: CJAMS-58984
   Category/ Module  : Services: Other
   Root cause:User request to remove the intake # I251013262289 is still in-progress.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58984'
where intakenumber = 'I251013262289';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58984'
where intakenumber  = 'I251013262289';