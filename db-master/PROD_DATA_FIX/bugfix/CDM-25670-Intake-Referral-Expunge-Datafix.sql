/*
 Issue Description:
 	CDM-25670: Record Needs Expunged 
 Category/ Module: Referral
 Root cause: 	User request to delete
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Update routing
select 	activeflag, * from routing 
where 	objectid in ('I202000257624')  and activeflag = 1; 

update 	routing 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-25670'
where 	objectid in ('I202000257624')  and activeflag = 1;

--update intakedastatus
select 	activeflag, * from intakedastatus
where 	intakenumber in ('I202000257624')  and activeflag = 1;

update 	intakedastatus 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-25670'
where 	intakenumber in ('I202000257624') and activeflag = 1;

--update intakedastaging
select 	activeflag, * from intakedastaging
where 	intakenumber  in ('I202000257624') and activeflag = 1;

update 	intakedastaging 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-25670'
where 	intakenumber  in ('I202000257624') and activeflag = 1;

--update intakesnapshot
select 	activeflag, * from intakesnapshot
where 	intakenumber  in ('I202000257624') and activeflag = 1;

update 	intakesnapshot 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-25670'
where 	intakenumber  in ('I202000257624') and activeflag = 1;

--update intakeservicerequest
select 	activeflag, * from intakeservicerequest
where 	intakenumber  in ('I202000257624') and activeflag = 1;

update 	intakeservicerequest 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-25670'
where 	intakenumber  in ('I202000257624') and activeflag = 1;