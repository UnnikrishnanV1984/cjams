/*
   Issue Description: CJAMS-69275
   Category/ Module  : Approval Inbox
   Root cause: user wants to remove approvals from pending tab
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


update routing 
set activeflag = 0, updatedby = 'CJAMS-69275', updatedon = now()
where objectid ='b7ff6884-2e25-4368-a944-8c924858498d' and activeflag  = 1 and routingstatustypeid = 15;