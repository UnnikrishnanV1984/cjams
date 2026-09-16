/*
   Issue Description: CJAMS-65858
   Category/ Module  : Intake
   Root cause: Data fix has been done to remove the intake
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastatus 
	set activeflag=0, updatedon = now(), updatedby = 'CJAMS-65858' 
where intakenumber ='I251013233060' and activeflag =1;

update intakedastaging 
	set activeflag=0, updatedon = now(), updatedby = 'CJAMS-65858' 
where intakenumber ='I251013233060' and activeflag =1;

update intakeservicerequestactor
set activeflag=0, updatedon = now(), updatedby = 'CJAMS-65858' 
where intakenumber ='I251013233060' and activeflag =1;
		
update actor
set activeflag=0, updatedon = now(), updatedby = 'CJAMS-65858' 
where intakenumber ='I251013233060' and activeflag =1;
		
UPDATE cjams.actorrelationship
set activeflag=0, updatedon = now(), updatedby = 'CJAMS-65858' 
where intakenumber ='I251013233060' and activeflag =1;

UPDATE cjams.personrole
set activeflag=0, updatedon = now(), updatedby = 'CJAMS-65858' 
where intakenumber ='I251013233060' and activeflag =1;

