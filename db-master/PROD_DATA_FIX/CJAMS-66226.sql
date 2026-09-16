
/*
Issue Description: Need data fix to remove a intake that is stuck on the workload dashboard for the worker. Intak number: I211010208366 and cannot be removed by the user.
Category/Module: Intake
Root cause: Intake records remained active in intakedastaging and intakedastatus tables for the intake number I211010208366 which is causing the intake to be stuck on the workload dashboard for the worker.
Fix provided: Soft delete the records in the intakedastaging and intakedastatus tables for the intake number I211010208366 by setting active flag to 0.
Data/Code fix ticket#: CJAMS-66226
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error, no code fix needed.Intake got stuck due to stale data.
Status of the code fix if already submitted and expected prod fix date: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
select * from intakedastaging where intakenumber = 'I211010208366' and activeflag =1 ;
select * from intakedastatus where intakenumber = 'I211010208366' and activeflag =1 ;
*/

update intakedastaging 
set activeflag =0, updatedon = now(), updatedby = 'CJAMS-66226' 
where intakenumber = 'I211010208366' and activeflag =1 ;

update intakedastatus  
set activeflag =0, updatedon = now(), updatedby = 'CJAMS-66226' 
where intakenumber = 'I211010208366' and activeflag =1 ;

-- No records found in the table intakesnapshot for intakenumber
-- No records found in the table intakeservicerequest for intakenumber
-- No records found in the table intakeservicerequestactor for intakenumber	
-- No records found in the table routing for intakenumber