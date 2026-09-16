/*
   Issue Description: CJAMS-66926
   Category/ Module  :  Requested to  remove the purchase authorization from Approval Inbox of emma.nowak1@maryland.gov
   Root Cause: User Wants to Remove purchase authorization approval request from Approval Inbox of emma.nowak1@maryland.gov
   Fix provided: Data fix has been done to remove case from case pending dashboard
   Is code fix required: N
   Pull request for code fix: 
   Reason why no related code fix: 
   
*/


update routing set activeflag =0, updatedby = 'CJAMS-66926',
 updatedon = now() where routingid  ='4245b847-c686-49c0-a4bf-6f83e26e752b' and eventcode ='PCAUTH';