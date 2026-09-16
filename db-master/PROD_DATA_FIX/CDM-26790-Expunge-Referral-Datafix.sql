/*
 Issue Description:
 	CDM-26790: Referral # I221010239128 needs to be expunged from the system. 
 Category/ Module: Referral
 Root cause: 	User request (No information entered in referral.)
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Update routing
select 	activeflag, * from routing 
where 	objectid = 'I221010239128' and activeflag = 1; 

update 	routing 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-26790'
where 	objectid = 'I221010239128' and activeflag = 1;

--update intakedastatus
select 	activeflag, * from intakedastatus
where 	intakenumber = 'I221010239128' and activeflag = 1;

update 	intakedastatus 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-26790'
where 	intakenumber = 'I221010239128' and activeflag = 1;

--update intakedastaging
select 	activeflag, * from intakedastaging
where 	intakenumber = 'I221010239128' and activeflag = 1;

update 	intakedastaging 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-26790'
where 	intakenumber = 'I221010239128' and activeflag = 1;

--update intakesnapshot
select 	activeflag, * from intakesnapshot
where 	intakenumber = 'I221010239128' and activeflag = 1;

update 	intakesnapshot 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-26790'
where 	intakenumber = 'I221010239128' and activeflag = 1;

--update intakeservicerequest
select 	activeflag, * from intakeservicerequest
where 	intakenumber = 'I221010239128' and activeflag = 1;

update 	intakeservicerequest 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-26790'
where 	intakenumber = 'I221010239128' and activeflag = 1;