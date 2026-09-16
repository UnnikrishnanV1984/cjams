/*
Issue:Need data fix to delete the intake from dashboard
Root Cause: User requested to remove the intake from the dashboard
Fix Provided (Data Fix Only):Data fix was done by deleting the intake.
Data/Code fix ticket#: CJAMS-62657
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
select * from intakedastaging where intakenumber = 'I251013371981' and activeflag = 1;
*/

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-62657'
where intakenumber = 'I251013371981'
	and activeflag = 1 ;
	
update intakedastatus 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-62657'
where intakenumber = 'I251013371981'
	and activeflag = 1 ;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-62657'
where intakenumber = 'I251013371981'
	and activeflag = 1 ;
	
update intakeservicerequest 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-62657'
where intakenumber = 'I251013371981'
	and activeflag = 1 ;
	
update routing 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-62657'
where objectid  = 'I251013371981'
	and activeflag = 1 ;