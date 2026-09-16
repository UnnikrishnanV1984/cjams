/*
 Issue Description: CDM-36504
 Category/ Module : Intake
 Root cause: I241011960998, user requested to delete the intake.
 Fix: Deleted the intake from intakedasstaging, intakedastatus, intakeservrequest, intakeservrequestactor, intakesnapshot, routing tables.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */

select *
	from intakedastatus
	where intakenumber in ('I241011960998')
		and activeflag = 1;

update intakedastatus
	set	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36504'
	where intakenumber in ('I241011960998')
		and activeflag = 1;
	
select *
	from intakedastaging
	where intakenumber in ('I241011960998')
		and activeflag = 1;
	
update intakedastaging
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36504'
	where intakenumber in ('I241011960998')
		and activeflag = 1;
	
select *
	from intakesnapshot
	where intakenumber in ('I241011960998')
		and activeflag = 1;
		
update intakesnapshot
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36504'
	where intakenumber in ('I241011960998')
		and activeflag = 1;
		
select *
	from intakeservicerequest
	where intakenumber = 'I241011960998'
	  and activeflag = 1;
		
update intakeservicerequest
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36504'
	where intakenumber = 'I241011960998'
		and activeflag = 1;
		
select * from intakeservicerequestactor 
	where intakeserviceid = 'daf1a06b-1bd2-4c61-b8eb-dbe59a0e4f45'
		and activeflag = 1;

update intakeservicerequestactor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36504'
	where intakeserviceid = 'daf1a06b-1bd2-4c61-b8eb-dbe59a0e4f45'
		and activeflag = 1;	
	
select *
	from routing
	where (objectid = 'I241011960998' 
		OR servicerequestnumber = 'I241011960998' 
		OR objectid = 'daf1a06b-1bd2-4c61-b8eb-dbe59a0e4f45')
	 and activeflag = 1;
	 
	 
update routing
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36504'
	where (objectid = 'I241011960998' 
		OR servicerequestnumber = 'I241011960998' 
		OR objectid = 'daf1a06b-1bd2-4c61-b8eb-dbe59a0e4f45')
	 and activeflag = 1;