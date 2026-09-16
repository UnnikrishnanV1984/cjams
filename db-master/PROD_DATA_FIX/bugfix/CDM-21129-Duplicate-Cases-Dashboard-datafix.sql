/*
 Issue Description:
 	CDM-21129: Duplicate Cases on dashboard 
 Category/ Module: Referral - Dashboard
 Root cause: 	User request  - Duplicate cases
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Update routing
--select 	activeflag, * from routing 
--where 	objectid  in ('I211010218284', 'I211010201725') and activeflag = 1; 
--
--update 	routing 
--set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-21129'
--where 	objectid  in ('I211010218284', 'I211010201725')  and activeflag = 1;

--update intakedastatus
select 	activeflag, * from intakedastatus
where 	intakenumber in ('I211010218284', 'I211010201725') and activeflag = 1;

update 	intakedastatus 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-21129'
where 	intakenumber in ('I211010218284', 'I211010201725') and activeflag = 1;

--update intakedastaging
select 	activeflag, * from intakedastaging
where 	intakenumber in ('I211010218284', 'I211010201725') and activeflag = 1;

update 	intakedastaging 
set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-21129'
where 	intakenumber in ('I211010218284', 'I211010201725') and activeflag = 1;

--update intakesnapshot
--select 	activeflag, * from intakesnapshot
--where 	intakenumber in ('I211010218284', 'I211010201725') and activeflag = 1;

--update 	intakesnapshot 
--set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-21129'
--where 	intakenumber in ('I211010218284', 'I211010201725') and activeflag = 1;

--update intakeservicerequest
--select 	activeflag, * from intakeservicerequest
--where 	intakenumber in ('I211010218284', 'I211010201725') and activeflag = 1;
--
--update 	intakeservicerequest 
--set 	activeflag = 0, updatedon = now(), updatedby = 'CDM-21129'
--where 	intakenumber in ('I211010218284', 'I211010201725') and activeflag = 1;