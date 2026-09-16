/*
Issue Description: 241030330592:This two-months-old Lily (PID#203130885) was incorrectly birthmatched with Mickael Wright who is casehead. Her father's identify does not match with this casehead. Baby Lily has no CWS/CPS Hx nor current involvement. We are requesting data fix to please delete her info from this case (especially per her parents' request).
Category/ Module  : Intakeservicerequestactor table
Root cause: Please do a data fix to remove the child from both case and intake.
Fix provided :yes, write db query
Code fix ticket#:CDM-39156
Reason why no related code fix: Status of the code fix already submitted
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete:
*/

--Removing from personrole table
update personrole
	set activeflag = 0,
	updatedby = 'CDM-39156',
	updatedon = now()
	where personid = 'e26d5191-7c76-4ad5-be41-d976951206e0'
	and intakeserviceid = '7ce6f9ae-5899-4a31-b726-ed7531dfe16c'
	and activeflag = 1 ;

--Removing from personroletype table
update personroletype 
	set activeflag = 0,
		updatedby = 'CDM-39156',
		updatedon = now()
		where personroleid in
			(select personroleid
			from personrole
			where personid = 'e26d5191-7c76-4ad5-be41-d976951206e0'
			and intakeserviceid = '7ce6f9ae-5899-4a31-b726-ed7531dfe16c')
		and activeflag = 1;

--Removing from personprogramarea table
update personprogramarea
	set activeflag = 0,
	updatedby = 'CDM-39156',
	updatedon = now()
	where personid = 'e26d5191-7c76-4ad5-be41-d976951206e0'
	and objectid = 'a8620c7f-ca8f-4fbe-90ce-6129e9803a28'
	and activeflag = 1 ;
	
--Removing from intakeservicerequestactor table
update intakeservicerequestactor
set
	activeflag = 0,
	updatedby = 'CDM-39156',
	updatedon = now()
	where personid = 'e26d5191-7c76-4ad5-be41-d976951206e0'
	and intakeserviceid = '7ce6f9ae-5899-4a31-b726-ed7531dfe16c'
	and activeflag = 1;

--Removing from actor table
update actor
set
	activeflag = 0,
	updatedby = 'CDM-39156',
	updatedon = now()
	where personid = 'e26d5191-7c76-4ad5-be41-d976951206e0'
	and intakeserviceid = '7ce6f9ae-5899-4a31-b726-ed7531dfe16c'
	and activeflag = 1 ;

--Removing from actorrelationship table
update actorrelationship	
set
	activeflag = 0,
	updatedby = 'CDM-39156',
	updatedon = now()
	where intakeservicerequestactorid in
		(select intakeservicerequestactorid
		from intakeservicerequestactor
		where personid = 'e26d5191-7c76-4ad5-be41-d976951206e0'
		and intakeserviceid = '7ce6f9ae-5899-4a31-b726-ed7531dfe16c')
	and activeflag = 1 ;