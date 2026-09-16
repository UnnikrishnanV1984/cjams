/*
 Issue Description: CDM-36216
 Category/ Module : Intake
 Root cause: I231011522836, user requested to delete the intake.
 Fix: Deleted the intake from intakedasstaging, intakedastatus, intakesnapshot, intakeservrequest, intakeservrequestactor tables, no records are found in routing table.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */
-- Intakestatus and Intakedasstaging tables

select *
	from intakedastatus
	where intakenumber in ('I231011522836')
		and activeflag = 1;

update intakedastatus
	set	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36216'
	where intakenumber in ('I231011522836')
		and activeflag = 1;
	
select *
	from intakedastaging
	where intakenumber in ('I231011522836')
		and activeflag = 1;
	
update intakedastaging
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36216'
	where intakenumber in ('I231011522836')
		and activeflag = 1;
	
select *
	from intakesnapshot
	where intakenumber in ('I231011522836');
		
update intakesnapshot
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36216'
	where intakenumber in ('I231011522836')
		and activeflag = 1;
	
select *
	from intakeservicerequest
	where intakenumber = 'I231011522836';
		
update intakeservicerequest
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36216'
	where intakenumber = 'I231011522836'
		and activeflag = 1;
		
select * from intakeservicerequestactor 
	where intakeserviceid = '64815e17-2c7c-4245-bc67-e42e174f576e';

update intakeservicerequestactor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36216'
	where intakeserviceid = '64815e17-2c7c-4245-bc67-e42e174f576e'
		and activeflag = 1;	
	
--No records found in below table
select *
	from routing
	where objectid = 'I231011522836' 
		OR servicerequestnumber = '231021395650' 
		OR objectid = '64815e17-2c7c-4245-bc67-e42e174f576e';
		
