/*
 Issue Description:CDM-43854
 Category/ Module: Data fix needed
 Root cause: User Error, delete intake
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
/*
select *
	from intakedastatus
	where intakenumber in ('I251013208343')
		and activeflag = 1;
*/
update intakedastatus
	set	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-43854'
	where intakenumber in ('I251013208343')
		and activeflag = 1;
/*	
select *
	from intakedastaging
	where intakenumber in ('I251013208343')
		and activeflag = 1;
*/		
update intakedastaging
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-43854'
	where intakenumber in ('I251013208343')
		and activeflag = 1;


--No records found in below table
/*select *
	from intakeservicerequest
	where intakenumber = 'I251013208343'
	  and activeflag = 1;
	  
select *
	from intakesnapshot
	where intakenumber in ('I251013208343')
		and activeflag = 1;
		
select *
	from routing
	where objectid = 'I251013208343' 
	 and activeflag = 1;

select * from intakeservicerequestactor 
	where intakenumber in ('I251013208343')
		and activeflag = 1;
		*/