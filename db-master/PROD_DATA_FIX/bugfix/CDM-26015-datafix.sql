-- CDM-26015 - Intake created in error
/*
-- Issue Description: 
 	User requested to delete the Intake #I221010327472

-- Category/ Module: Intake/Referral
-- Root cause: User Request
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Routing Not needed as there is no record
--select * from routing where objectid='I221010327472';
--update routing set activeflag=0,updatedon=now(),updatedby='CDM-26015'where objectid='I221010327472';

select * from intakedastatus where intakenumber='I221010327472';
update 	intakedastatus 
set 	activeflag=0, updatedon=now(), updatedby='CDM-26015'
where 	intakenumber='I221010327472';

select * from intakedastaging  where intakenumber='I221010327472';
update 	intakedastaging 
set 	activeflag=0, updatedon=now(), updatedby='CDM-26015' 
where 	intakenumber='I221010327472';

--snapshot not needed to update as there is no record
--select * from intakesnapshot  where intakenumber='I221010327472';
--update intakesnapshot set activeflag=0,updatedon=now(),updatedby='CDM-26015'where intakenumber='I221010327472';