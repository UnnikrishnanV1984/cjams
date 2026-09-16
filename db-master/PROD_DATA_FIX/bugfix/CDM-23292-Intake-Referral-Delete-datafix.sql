/*
 Issue Description:
 	CDM-23292: Intake referrals 
 Category/ Module: Referral
 Root cause: 	User request to delete
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Update routing
select 	activeflag, * from routing 
where 	objectid in ('CW9952441', 'I221010245160', 'I211010175306', 'I221010254919', 'I202000376297', 'I202100129476')  and activeflag = 1; 

update 	routing 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-23292'
where 	objectid in ('CW9952441', 'I221010245160', 'I211010175306', 'I221010254919', 'I202000376297', 'I202100129476')  and activeflag = 1;

--update intakedastatus
select 	activeflag, * from intakedastatus
where 	intakenumber in ('CW9952441', 'I221010245160', 'I211010175306', 'I221010254919', 'I202000376297', 'I202100129476')  and activeflag = 1;

update 	intakedastatus 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-23292'
where 	intakenumber in ('CW9952441', 'I221010245160', 'I211010175306', 'I221010254919', 'I202000376297', 'I202100129476') and activeflag = 1;

--update intakedastaging
select 	activeflag, * from intakedastaging
where 	intakenumber  in ('CW9952441', 'I221010245160', 'I211010175306', 'I221010254919', 'I202000376297', 'I202100129476') and activeflag = 1;

update 	intakedastaging 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-23292'
where 	intakenumber  in ('CW9952441', 'I221010245160', 'I211010175306', 'I221010254919', 'I202000376297', 'I202100129476') and activeflag = 1;

--update intakesnapshot
select 	activeflag, * from intakesnapshot
where 	intakenumber  in ('CW9952441', 'I221010245160', 'I211010175306', 'I221010254919', 'I202000376297', 'I202100129476') and activeflag = 1;

update 	intakesnapshot 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-23292'
where 	intakenumber  in ('CW9952441', 'I221010245160', 'I211010175306', 'I221010254919', 'I202000376297', 'I202100129476') and activeflag = 1;

--update intakeservicerequest
select 	activeflag, * from intakeservicerequest
where 	intakenumber  in ('CW9952441', 'I221010245160', 'I211010175306', 'I221010254919', 'I202000376297', 'I202100129476') and activeflag = 1;

update 	intakeservicerequest 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-23292'
where 	intakenumber  in ('CW9952441', 'I221010245160', 'I211010175306', 'I221010254919', 'I202000376297', 'I202100129476') and activeflag = 1;