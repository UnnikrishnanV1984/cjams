/*
   Issue Description: CDM-30644
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
    updatedby = 'CDM-30644',
    updatedon = now()
where routingid ='789ab6fc-e9ba-4c1e-a3df-a755269c2fac' and objectid = 'e5916dae-a37e-4f74-9127-00a9f008ac7b';