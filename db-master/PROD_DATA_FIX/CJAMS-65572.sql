/*
   Issue Description: CJAMS-65572
   Category/ Module  : Intake
   Root cause: User requested to remove Intake 
   Fix provided: Data fix is done to remove the intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65572'
where intakenumber = 'I261013892735'
	and activeflag = 1 ;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65572'
where intakenumber = 'I261013892735'
	and activeflag = 1 ;

update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65572'
where intakenumber = 'I261013892735'
	and activeflag = 1 ;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65572'
where intakenumber = 'I261013892735'
	and activeflag = 1 ;