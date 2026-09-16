--Issue CDM-27424-intake-needs-deleted
/*
-- Issue Description: 
	1. User requested to delete Intake #I221010322880 from the system

-- Category/ Module: Intake
-- Root cause: User request. Intake needs to be deleted as subsequent intake was created and approved. This intake is stuck and unable to be approved/disapproved

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--No Records found
--------------------------------------------------------------------------------------------------------
select * from cjams.intakeservicerequest where intakenumber ='I221010322880' and activeflag =1;

select * from  intakesnapshot where intakenumber ='I221010322880' and activeflag =1;

select * from routing where objectid ='I221010322880' and activeflag =1;
----------------------------------------------------------------------------------------------------------------


update intakedastaging set activeflag = 0,
updatedby = 'CDM-27517', updatedon = now()
where intakenumber = 'I221010322880' and activeflag = 1;

update intakedastatus set activeflag = 0,
updatedby = 'CDM-27517', updatedon = now()
where intakenumber = 'I221010322880' and activeflag = 1;