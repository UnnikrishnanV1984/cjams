/*
   Issue Description: CDM-37514 - Case # 20200140855
   Category/ Module  : Approval Inbox
   Root cause: There is no pending review APPLA assessment available but approval inbox has a request. User requested to remove it.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix: Data fix to remove the approval request record.
*/

update routing 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37514'
    where routingid = 'd600c0f7-bd6f-45f6-ae05-17ada7cfcad0'
    	and activeflag = 1;