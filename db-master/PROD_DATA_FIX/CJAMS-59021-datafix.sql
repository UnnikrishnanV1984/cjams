/*
   Issue Description: CJAMS-59021
   Category/ Module  : Documents
   Root cause: Data fix has been done to remove the intake
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59021'
where intakenumber  = 'I251013264060';

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59021'
where objectid = 'I251013264060';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59021'
where intakenumber = 'I251013264060';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59021'
where intakenumber = 'I251013264060';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59021'
where intakenumber = 'I251013264060';

update intakeservicerequestactor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-59021'
	where intakenumber = 'I251013264060'
		and activeflag = 1;
		
		update actor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-59021'
	where intakenumber = 'I251013264060'
		and activeflag = 1;
		
UPDATE cjams.actorrelationship
SET updatedby = 'CJAMS-59021',updatedon = now(),activeflag =0
where intakenumber='I251013264060';

UPDATE cjams.personrole
SET updatedby = 'CJAMS-59021',updatedon = now(),activeflag =0
where intakenumber='I251013264060';