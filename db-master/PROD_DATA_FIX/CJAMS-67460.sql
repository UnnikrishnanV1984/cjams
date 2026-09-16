/*
Issue Description: CJAMS-67460
Category/Module: Delete referral
Root cause: User requested to remove the intake referrals I261014013681, as user had created by error
Fix provided: Data fix has been promoted to remove the intake referral I261014013681
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/



update intakedastatus 
set activeflag=0,updatedon=now(),updatedby='CJAMS-67460'
where intakenumber ='I261014013681' and activeflag=1;

update intakedastaging 
set activeflag=0,updatedon=now(),updatedby='CJAMS-67460'
where intakenumber ='I261014013681' and activeflag=1;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-67460'
where intakenumber = 'I261014013681'
	and activeflag = 1 ;
	
update intakeservicerequest 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-67460'
where intakenumber = 'I261014013681'
	and activeflag = 1 ;
	
update routing 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-67460'
where objectid  = 'I261014013681'
	and activeflag = 1 ;