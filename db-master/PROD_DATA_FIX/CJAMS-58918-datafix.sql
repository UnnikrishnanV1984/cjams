/*
   Issue Description: CJAMS-58918
   Category/ Module  : Services: Other
   Root cause:User request to remove the intake # I251013260263 is still in-progress.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58918'
where intakenumber = 'I251013260263' and activeflag = 1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58918'
where intakenumber = 'I231010545536' and activeflag = 1;