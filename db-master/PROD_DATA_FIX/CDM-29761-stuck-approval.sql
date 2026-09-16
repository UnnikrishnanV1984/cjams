/*
   Issue Description: CDM-29761
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
    updatedby = 'CDM-29761',
    updatedon = now()
where
    routingid = '518d9a20-6c7a-4313-8d45-4bb4dd9e102d';