--Issue CDM-35813-Old Intakes need to be closed
/*
-- Issue Description: 
	1. User requested to delete intakes I221010291328, I221010267436, I202000567700 from the system

-- Category/ Module: Intake
-- Root cause:  Old Intakes assigned to staff in error. None appear to contain any CPS allegations that require assignment or screening decisions. Staff are unable to send for review to close
-- Fix Provided:Provided Data fix to soft delete intakes I221010291328, I221010267436, I202000567700

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--No Records found
---------------------------------------------------------------------------------------
select *from routing where objectid='I221010291328' and activeflag=1;

select *from intakesnapshot where intakenumber='I221010291328' and activeflag=1;

select *from routing where objectid='I221010267436' and activeflag=1;                          

select *from intakesnapshot where intakenumber='I221010267436' and activeflag=1;

select *from routing where objectid='I202000567700' and activeflag=1 ;

select *from intakesnapshot where intakenumber='I202000567700' and activeflag=1;
---------------------------------------------------------------------------------------

update intakedastaging set activeflag = 0,
updatedby = 'CDM-35813', updatedon = now()
where intakenumber = 'I221010291328' and activeflag = 1;

update intakedastatus set activeflag = 0,
updatedby = 'CDM-35813', updatedon = now()
where intakenumber = 'I221010291328' and activeflag = 1;

update intakedastaging set activeflag = 0,
updatedby = 'CDM-35813', updatedon = now()
where intakenumber = 'I221010267436' and activeflag = 1;

update intakedastatus set activeflag = 0,
updatedby = 'CDM-35813', updatedon = now()
where intakenumber = 'I221010267436' and activeflag = 1;

update intakedastaging set activeflag = 0,
updatedby = 'CDM-35813', updatedon = now()
where intakenumber = 'I202000567700' and activeflag = 1;

update intakedastatus set activeflag = 0,
updatedby = 'CDM-35813', updatedon = now()
where intakenumber = 'I202000567700' and activeflag = 1;




