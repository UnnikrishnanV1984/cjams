-- CDM-36407 - SCREEN OUT
/* Issue Description: Remove record from pending transfers

-- Intake case number: I231011831088

-- Category/ Module: Decision

-- Root cause: User request to screen out the case #I231011831088 & remove record from pending transfers
-- Fix Provided: Datafix has been provided to update case to screenout
-- Pull request# N/A

*/
select * from intaketransfers where intakenumber = 'I231011831088';

update intaketransfers
	set approvalstatus = 'Approved',
		updatedby = 'CDM-36407',
		updatedon = now()
	where intaketransferid = 'a6aee996-48e8-4749-bd1a-70f623b9a198';