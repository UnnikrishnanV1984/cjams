/*
   Issue Description: 20560
   Category/ Module  :Approval Inbox
   Root cause: user wants to remove approved record 
   Pull request# for code fix: 6660
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed. Need to do data fix
*/
update routing 
set activeflag = 0,
    updatedby = 'CDM-20560',
    updatedon = now()
where routingid = '59e5df8b-90b8-4adf-8b44-e9ef7f9c8ae0';