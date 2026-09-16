/*
   Issue Description: CDM-35424
   Category/ Module  : delete intake
   Root cause: user wants to delete intake #I202000066841 as it's an old referral which not going to be proceed.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35424'
where objectid = 'I202000066841';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35424'
where intakenumber = 'I202000066841';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35424'
where intakenumber = 'I202000066841';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35424'
where intakenumber = 'I202000066841';
