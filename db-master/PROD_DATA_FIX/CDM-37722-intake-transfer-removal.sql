/*
-- CDM-37722 - Transfer was not complete. Needs Data fix to remove from Pending Transfer Dashboard
-- Issue Description: I231010545421:Duplicate referrals. Dorchester screened the referral and sup did not receive it in the transfer box. This referral should be removed from dashboard.
-- Intake case number: I231010545421
-- Category/ Module: Decision
-- Root cause: I231010545421:Duplicate referrals. Dorchester screened the referral and sup did not receive it in the transfer box. This referral should be removed from dashboard.
-- Fix Provided: Datafix has been promoted to remove the Pending Transfer Request
-- Pull Request# N/A
*/

select * from intaketransfers where intakenumber = 'I231010545421';

update intaketransfers
set    activeflag = 0,
       updatedby = 'CDM-37722',
       updatedon = now()
where  intaketransferid = '4d056983-79ac-4365-87ff-5ba8ce9af6b3';


select * from routing
where objectid = '4d056983-79ac-4365-87ff-5ba8ce9af6b3'
and eventcode = 'INTTRF';

update routing
set    activeflag = 0,
       updatedby = 'CDM-37722',
       updatedon = now()
where  objectid = '4d056983-79ac-4365-87ff-5ba8ce9af6b3'
and    eventcode= 'INTTRF';