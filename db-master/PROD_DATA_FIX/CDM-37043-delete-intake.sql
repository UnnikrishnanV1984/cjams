--Issue CDM-37043 Duplicate Referral-intake-needs-deleted
/*
-- Issue Description: 
	1. User requested to delete Intake #I231011250572 from the system

-- Category/ Module: Intake
-- Root cause: User request. There was a CJAMS error during entry and a new referral was entered. This referral can be deleted

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--No Records found
--------------------------------------------------------------------------------------------------------
select * from cjams.intakeservicerequest where intakenumber ='I231011250572' and activeflag =1;

select * from  intakesnapshot where intakenumber ='I231011250572' and activeflag =1;

select * from routing where objectid ='I231011250572' and activeflag =1;
----------------------------------------------------------------------------------------------------------------


update intakedastaging set activeflag = 0,
updatedby = 'CDM-37043', updatedon = now()
where intakenumber = 'I231011250572' and activeflag = 1;

update intakedastatus set activeflag = 0,
updatedby = 'CDM-37043', updatedon = now()
where intakenumber = 'I231011250572' and activeflag = 1;