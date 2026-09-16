/*
 Issue Description: CDM-36294
 Category/ Module : Intake
 Root cause: CW9939508, user requested to delete the intake.
 Fix: Deleted the intake from intakedasstaging, intakedastatus, intakeservrequest, intakeservrequestactor tables.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */
-- Intakestatus and Intakedasstaging tables

select *
	from intakedastatus
	where intakenumber in ('CW9939508')
		and activeflag = 1;

update intakedastatus
	set	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36294'
	where intakenumber in ('CW9939508')
		and activeflag = 1;
	
select *
	from intakedastaging
	where intakenumber in ('CW9939508')
		and activeflag = 1;
	
update intakedastaging
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36294'
	where intakenumber in ('CW9939508')
		and activeflag = 1;
	

select *
	from intakeservicerequest
	where intakenumber = 'CW9939508'
	  and activeflag = 1;
		
update intakeservicerequest
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36294'
	where intakenumber = 'CW9939508'
		and activeflag = 1;
		
select * from intakeservicerequestactor 
	where intakeserviceid = '767f3d5b-5d4c-4b90-8274-eed9cd32b583'
		and activeflag = 1;

update intakeservicerequestactor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36294'
	where intakeserviceid = '767f3d5b-5d4c-4b90-8274-eed9cd32b583'
		and activeflag = 1;	
	
--No records found in below table

select *
	from intakesnapshot
	where intakenumber in ('CW9939508')
		and activeflag = 1;
		
		
select *
	from routing
	where (objectid = 'CW9939508' 
		OR servicerequestnumber = 'CW9939508' 
		OR objectid = '767f3d5b-5d4c-4b90-8274-eed9cd32b583')
	 and activeflag = 1;