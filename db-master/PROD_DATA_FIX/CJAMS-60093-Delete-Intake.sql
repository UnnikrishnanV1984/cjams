/*
   Issue Description: CJAMS-60093
   Category/ Module  : Intake
   Root cause: Data fix has been done to remove the intake
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastatus 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-60093' 
where intakenumber = 'I251013222687' and activeflag =1;

update intakedastaging 
	set activeflag=0, updatedon = now(), updatedby = 'CJAMS-60093' 
where intakenumber ='I251013222687' and activeflag=1;

update intakesnapshot 
	set activeflag=0, updatedon = now(), updatedby = 'CJAMS-60093' 
where intakenumber ='I251013222687' and activeflag=1;

update intakeservicerequest 
	set actiontype=null, updatedon = now(), updatedby = 'CJAMS-60093' ,activeflag =0
where intakenumber ='I251013222687' and activeflag=1;

/*
 * no routing 
update routing 
	set activeflag=0, updatedon = now(), updatedby = 'CJAMS-60093' 
where routingid ='f3110686-3bd5-48fe-a697-c56f3a7277e6' and activeflag=1;
*/

update intakeservicerequestactor
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-60093'
where intakenumber = 'I251013222687'
    and activeflag = 1;
		
update actor
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-60093'
where intakenumber = 'I251013222687'
	and activeflag = 1;
		
UPDATE cjams.actorrelationship
SET updatedby = 'CJAMS-60093',updatedon = now(),activeflag =0
where intakenumber='I251013222687';

UPDATE cjams.personrole
SET updatedby = 'CJAMS-60093',updatedon = now(),activeflag =0
where intakenumber='I251013222687';
