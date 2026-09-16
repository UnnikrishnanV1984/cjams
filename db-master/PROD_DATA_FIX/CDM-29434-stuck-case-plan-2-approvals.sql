/*
   Issue Description: CDM-29434
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
    updatedby = 'CDM-29434',
    updatedon = now()
where
    routingid in (
        '14a25666-d98d-4ad8-8cb5-6e5d1532451f',
        'e75dfd41-876f-49f9-96ba-c80c5b9724bc',
        '496821a9-caac-4cac-9de3-90532dea34a8'
    );