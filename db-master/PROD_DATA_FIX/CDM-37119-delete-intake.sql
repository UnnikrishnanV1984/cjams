--Issue CDM-37119-Case Opened in Error
/*
-- Issue Description: 
	I231011747079:This case was opened in Error and needs to be deleted
-- Category/ Module: Intake
-- Root cause: User request. Intake needs to be deleted as it was created by error.
*/

--No Records found
--------------------------------------------------------------------------------------------------------
select * from cjams.intakeservicerequest where intakenumber ='I231011747079' and activeflag =1;

select * from  intakesnapshot where intakenumber ='I231011747079' and activeflag =1;

select * from routing where objectid ='I231011747079' and activeflag =1;
----------------------------------------------------------------------------------------------------------------


update intakedastaging set activeflag = 0,
updatedby = 'CDM-37119', updatedon = now()
where intakenumber = 'I231011747079' and activeflag = 1;

update intakedastatus set activeflag = 0,
updatedby = 'CDM-37119', updatedon = now()
where intakenumber = 'I231011747079' and activeflag = 1;