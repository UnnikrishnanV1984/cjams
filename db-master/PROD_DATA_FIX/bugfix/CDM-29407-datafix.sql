/*
   Issue Description: CDM-29407
   Category/ Module  : Approval Inbox
   Pull request# for code fix: User asked to remove approved record in approval inbox
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. 
    Need to do data fix
*/
update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-29407',
    updatedon = now()
where
    objectid = 'c20f1e8a-2201-4678-b3bf-d1faf359752c'