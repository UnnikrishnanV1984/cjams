/*
   Issue Description: CDM-31448
   Category/ Module  : Delete intake
   Root cause: user wants to delete intake as its a duplicate 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-31448'
where intakenumber = 'I231010607752' and activeflag=1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-31448'
where intakenumber = 'I231010607752'and activeflag=1;