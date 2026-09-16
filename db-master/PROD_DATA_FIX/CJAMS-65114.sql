/*
   Issue Description: CJAMS-65114
   Category/ Module  : Intake
   Root cause: user error, Requested for a datafix 
   Fix provided : Data fix has been done to remove the intake
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/




update intakedastatus 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-65114' 
where intakenumber = 'I261013754942' and activeflag =1;

update intakedastaging 
	set activeflag=0, updatedon = now(), updatedby = 'CJAMS-65114' 
where intakenumber ='I261013754942' and activeflag=1;


/* no record */
/*update intakesnapshot 
	set activeflag=0, updatedon = now(), updatedby = 'CJAMS-65114' 
where intakenumber ='I261013754942' and activeflag=1; */


/* No record 
update intakeservicerequest 
	set actiontype=null, updatedon = now(), updatedby = 'CJAMS-65114' ,activeflag =0
where intakenumber ='I261013754942' and activeflag=1;*/


update routing 
	set activeflag=0, updatedon = now(), updatedby = 'CJAMS-65114' 
where routingid ='60c6ab0e-118e-4af7-ae23-be0d953689ca' and activeflag=1;

update intakeservicerequestactor
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65114'
where intakenumber = 'I261013754942'
    and activeflag = 1;
		
update actor
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-65114'
where intakenumber = 'I261013754942'
	and activeflag = 1;

UPDATE cjams.actorrelationship
SET updatedby = 'CJAMS-65114',updatedon = now(),activeflag =0
where intakenumber='I261013754942';

/* Active flag 0 in personrole table */
