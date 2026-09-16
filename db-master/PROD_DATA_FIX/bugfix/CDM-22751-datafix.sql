/*
   Issue Description: CDM-26088
   Category/ Module  : Approval Inbox
   Root cause: User requested to delete approved record from Approval Inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update 	routing 
set 	activeflag = 0,
		updatedby ='CDM-22751',
		updatedon = now()
where routingid in ('c411dda7-e7a9-4640-bbc7-3ff88c5e8ad2', '59e5df8b-90b8-4adf-8b44-e9ef7f9c8ae0');