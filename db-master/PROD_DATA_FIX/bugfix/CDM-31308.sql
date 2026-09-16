/*
   Issue Description: CDM-31308
   Category/ Module  : delete intake 
   Root cause: user wants to delete intake
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-31308'
where intakenumber = 'I231010518309'and activeflag=1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-31308'
where intakenumber = 'I231010518309' and activeflag=1;
