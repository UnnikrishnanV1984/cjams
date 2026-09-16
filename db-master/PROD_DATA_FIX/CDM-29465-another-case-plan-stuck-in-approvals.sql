/*
   Issue Description: CDM-29465
   Category/ Module  : Approval Inbox
   Pull request# for code fix: User asked to remove approved record in pending 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. 
    Need to do data fix
*/
update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-29465',
    updatedon = now()
where
    routingid = '4b67d25c-e0ca-4bf7-abbf-c42d6501f2d5';