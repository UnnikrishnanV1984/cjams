/*
 Issue Description:CJAMS-66259
 Category/ Module: delete intake I261013886949
 Root cause: User requested to delete intake I261013886949 from cjams
 Fix provided: Data fix is done to remove the intake 
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/



update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-66259'
where intakenumber = 'I261013886949'
	and activeflag = 1 ;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-66259'
where intakenumber = 'I261013886949'
	and activeflag = 1 ;
