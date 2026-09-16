/*
   Issue Description: CJAMS-67485
   Category/ Module  :  Requested to  remove the case from Approval Inbox of pam.thompsen@maryland.gov
   Root Cause: User Wants to Remove case from  approval request from Approval Inbox of pam.thompsen@maryland.gov
   Fix provided: Data fix has been done to remove case from case pending dashboard
   Is code fix required: N
   Pull request for code fix: 
   Reason why no related code fix: 
   
*/


update routing set activeflag =0, updatedby = 'CCJAMS-67485',
 updatedon = now() where routingid  ='24d1c501-7742-45e4-9e67-48be837f6fc4' and eventcode ='SCCR';