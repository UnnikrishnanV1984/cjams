/*
   Issue Description: CDM-29309
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
    updatedby = 'CDM-29309',
    updatedon = now()
where
    routingid in ('d8fbad2c-fd57-4af6-be81-402112adeb25','1986df46-8917-4dc4-b42b-f3f6c4e68957');