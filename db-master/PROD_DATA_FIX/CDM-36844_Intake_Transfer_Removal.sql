/*
-- CDM-36844 - SCREEN OUT -- case still on dashboard
-- Issue Description: Please remove the case transfer approval as the referral has been closed by the Carrol county user.
-- Intake case number: I231011332412
-- Category/ Module: Decision
-- Root cause: After Raising the Transfer Request, Before Approval, Intake I231011332412 itself is Closed. 
	       That is why Transfer History showing without Approval Information.
-- Fix Provided: Datafix has been provided to remove the Pending Transfer Request
-- Pull Request# N/A
*/

select * from intaketransfers where intakenumber = 'I231011332412';

update intaketransfers
set    activeflag = 0,
       updatedby = 'CDM-36844',
       updatedon = now()
where  intaketransferid = 'f3de8bb2-47ff-4908-bd47-42367549f207';