/*
   Issue Description: CDM-21544
   Category/ Module  : Approval Inbox
   Root cause: Case was closed but still appearing in user's inbox.

   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Data fix: Updating activeflag to 0 in the routing table for the servicerequest
*/


update 	routing 
set 	activeflag = 0,
		updatedby = 'CDM-21544',
		updatedon = now()
where 	objectid = '2bdecea7-e695-4744-8129-a70453c134b7'
        and eventcode  = 'SCCR'
        and activeflag  = 1;