/*
   Issue Description: CDM-29819
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
    updatedby = 'CDM-29819',
    updatedon = now()
where
    routingid = 'be0ed832-f865-4d40-98d9-9accfcbcb5ba';