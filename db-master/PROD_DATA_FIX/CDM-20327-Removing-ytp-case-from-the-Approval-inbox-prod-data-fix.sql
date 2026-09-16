/*
   Issue Description: CDM-20327
   Category/ Module  : TY case plan is approved but is still showing in my Approval Inbox. Appears to be stuck.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag = 0, updatedby = 'CDM-20327', updatedon = now where routingid = 'fb20b0d3-8e3c-4983-a7b1-6919ae3126e6';