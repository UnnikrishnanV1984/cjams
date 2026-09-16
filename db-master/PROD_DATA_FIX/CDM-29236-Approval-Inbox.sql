/*
   Issue Description: CDM-29236
   Category/ Module  : Approval Inbox
   Pull request# for code fix: User asked to remove approved record in pending 
   Reason why no related code fix: 8194
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. 
    Need to do data fix
*/
update 	routing
set activeflag = 0,updatedby = 'CDM-29236',updatedon = now()
where 	routingid = 'e78957a3-3488-413b-8cdb-5bfd0f60c0da';