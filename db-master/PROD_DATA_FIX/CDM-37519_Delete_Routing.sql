/*
   Issue Description: CDM-37519 - There are (4) case plans that have already been approved that are stuck in the Program Manager, Netricia Barnett's approval box. Please remove.
   Category/ Module  : Approval Inbox
   Root cause: There is no pending case plans available but approval inbox has a request for Program Manager, Netricia Barnett. User requested to remove it.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix: Data fix to remove the approval request record.
*/

update routing 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37519'
    where routingid IN ('e8a8dda2-3f34-428a-b453-a95397f1125e',
						'f47e3b45-8df9-4571-9232-314136785535',
						'80a8ccbe-5166-4ca9-b756-4837b34ad4ee',
						'738865df-b0ff-42a5-8c30-9f8f504f35a8')	
    	and activeflag = 1;
		
		
	