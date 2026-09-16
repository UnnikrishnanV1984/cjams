/*
   Issue Description: CJAMS-59821
   Category/ Module  : 
   Root cause: User requested to remove intake as new intake was created
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/ 
--select * from intakedastaging where intakenumber = 'I251013292086' and activeflag=1;

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59821'
where intakenumber ='I251013292086'
	and activeflag = 1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59821'
where intakenumber = 'I251013292086'
	and activeflag =1;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59821'
where intakenumber  = 'I251013292086';

update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59821'
where intakenumber ='I251013292086'
	and activeflag = 1;
	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59821'
where objectid ='I251013292086'
	and activeflag = 1;
