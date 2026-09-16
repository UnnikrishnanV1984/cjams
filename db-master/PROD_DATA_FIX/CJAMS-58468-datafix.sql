/*
   Issue Description: CJAMS-58468
   Category/ Module  : delete intake 
   Root cause: user wants to delete intake
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58468'
where intakenumber = 'I251013208198'
	and activeflag = 1 ;

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58468'
where intakenumber = 'I251013208198'
	and activeflag = 1 ;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58468'
where intakenumber = 'I251013208198' 
	and activeflag = 1 ;

update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-58468'
where intakenumber = 'I251013208198'
	and activeflag = 1 ;