/*
   Issue Description: CDM-30643
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
    updatedby = 'CDM-30643',
    updatedon = now()
where routingid = '768c476b-3296-4a6d-9f95-6695da2aac26' and objectid = '15b3eb1a-6cab-4511-92be-26a6313ccafe';