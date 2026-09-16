/*
 Issue Description:
 	CDM-26791: Referral # I221010230492 needs to be expunged from the system. 
 Category/ Module: Referral
 Root cause: 	Worker started a new referral with the same information (221010230513) which was submitted and screened on 1/13/22
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Update routing
select 	activeflag, * from routing 
where 	objectid = 'I221010230492' and activeflag = 1; 

update 	routing 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-26791'
where 	objectid = 'I221010230492' and activeflag = 1;

--update intakedastatus
select 	activeflag, * from intakedastatus
where 	intakenumber = 'I221010230492' and activeflag = 1;

update 	intakedastatus 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-26791'
where 	intakenumber = 'I221010230492' and activeflag = 1;

--update intakedastaging
select 	activeflag, * from intakedastaging
where 	intakenumber = 'I221010230492' and activeflag = 1;

update 	intakedastaging 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-26791'
where 	intakenumber = 'I221010230492' and activeflag = 1;

--update intakesnapshot
select 	activeflag, * from intakesnapshot
where 	intakenumber = 'I221010230492' and activeflag = 1;

update 	intakesnapshot 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-26791'
where 	intakenumber = 'I221010230492' and activeflag = 1;

--update intakeservicerequest
select 	activeflag, * from intakeservicerequest
where 	intakenumber = 'I221010230492' and activeflag = 1;

update 	intakeservicerequest 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-26791'
where 	intakenumber = 'I221010230492' and activeflag = 1;