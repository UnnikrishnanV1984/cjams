--Issue CDM-37045-Duplicate Referral
/*
-- Issue Description: 
	I231010876390:There was a CJAMS error during entry and a new referral was entered and needs to be deleted.
-- Category/ Module: Intake
-- Root cause: User request. Intake needs to be deleted as subsequent intake was created and approved. 
*/

--No Records found
--------------------------------------------------------------------------------------------------------
select * from cjams.intakeservicerequest where intakenumber ='I231010876390' and activeflag =1;

select * from  intakesnapshot where intakenumber ='I231010876390' and activeflag =1;

select * from routing where objectid ='I231010876390' and activeflag =1;
----------------------------------------------------------------------------------------------------------------


update intakedastaging set activeflag = 0,
updatedby = 'CDM-27517', updatedon = now()
where intakenumber = 'I231010876390' and activeflag = 1;

update intakedastatus set activeflag = 0,
updatedby = 'CDM-27517', updatedon = now()
where intakenumber = 'I231010876390' and activeflag = 1;