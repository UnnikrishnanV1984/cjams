/*
 Issue Description: CDM-37259
 Category/ Module : Intake
 Root cause: I202000678618 , user requested to delete the intake.
 Fix: Deleted the intake from intakedasstaging, intakedastatus tables.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */

select *
	from intakedastatus
	where intakenumber in ('I202000678618')
		and activeflag = 1;

update intakedastatus
	set	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37259'
	where intakenumber in ('I202000678618')
		and activeflag = 1;
	
select *
	from intakedastaging
	where intakenumber in ('I202000678618')
		and activeflag = 1;
	
update intakedastaging
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37259'
	where intakenumber in ('I202000678618')
		and activeflag = 1;
		
select * from intakeservicerequestactor 
	where intakenumber in ('I202000678618')
		and activeflag = 1;

update intakeservicerequestactor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37259'
	where intakenumber in ('I202000678618')
		and activeflag = 1;	

select *
	from actor
	where intakenumber = 'I202000678618' 
	 and activeflag = 1;		
	 
update actor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37259'
	where intakenumber in ('I202000678618')
		and activeflag = 1;

select *
	from actorrelationship
	where intakenumber = 'I202000678618' 
	 and activeflag = 1;

update actorrelationship
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37259'
	where intakenumber in ('I202000678618')
		and activeflag = 1;	

select *
	from personrole
	where intakenumber = 'I202000678618' 
	 and activeflag = 1;
	 
update personrole
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37259'
	where intakenumber in ('I202000678618')
		and activeflag = 1;			

--No records found in below table
select *
	from intakeservicerequest
	where intakenumber = 'I202000678618'
	  and activeflag = 1;
	  
select *
	from intakesnapshot
	where intakenumber in ('I202000678618')
		and activeflag = 1;
		
select *
	from routing
	where objectid = 'I202000678618' 
	 and activeflag = 1;