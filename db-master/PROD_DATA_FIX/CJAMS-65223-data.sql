/*
 Issue Description:CJAMS-65223
 Category/ Module: delete intake I261013890227
 Root cause: User requested to delete intake I261013890227 from cjams
 Fix provided: Data fix is done to remove the intake 
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/



update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65223'
where intakenumber = 'I261013890227'
	and activeflag = 1 ;
	
update intakedastatus 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65223'
where intakenumber = 'I261013890227'
	and activeflag = 1 ;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65223'
where intakenumber = 'I261013890227'
	and activeflag = 1 ;
	
update intakeservicerequest 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65223'
where intakenumber = 'I261013890227'
	and activeflag = 1 ;
	
update routing 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65223'
where objectid  = 'I261013890227'
	and activeflag = 1 ;