/*
   Issue Description: CDM-20102
   Category/ Module  : Plan removal from inbox
   Root cause: user wants to remove approved YTP from supervisor approval inbox
   Pull request# for code fix: 4737
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update routing 
set activeflag = 0, updatedby = 'CDM-20102', updatedon = now()
where routingid in ('56626e2d-1679-4d73-a582-2bcdd32996c2', 'd416d95a-9131-4d9d-8169-27da1397e4c3');