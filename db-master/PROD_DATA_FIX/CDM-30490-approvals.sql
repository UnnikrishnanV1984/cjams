/*
   Issue Description: CDM-30490
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
    updatedby = 'CDM-30490',
    updatedon = now()
where
    routingid = '6a6370a6-fe3d-4e1f-8792-e000eb5d8546';



