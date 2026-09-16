/*
   Issue Description: CDM-30642
   Category/ Module  : Approval Inbox
   Root cause: Previous datafix which update the status to open reverting that.
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing 
set activeflag =0, updatedon =now(), updatedby ='CDM-30642'
where routingid ='915f8122-ffab-4cc5-8285-8aadc99ee64a';