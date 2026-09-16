/*
   Issue Description: CDM-30453
   Category/ Module  : Dashboard
   Root cause: user requested to remove pending approval from dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    
*/

update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-44195'
where actorid ='88625b4c-9439-4635-9d49-0f7d65d2218b'
	 and intakeserviceid ='47ce4f4b-18dc-4f91-a43a-44739bab27b5'
	 and activeflag = 1;

update cjams.intakeservicerequestactor  
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-44195'
where intakeservicerequestactorid = '4040e67c-25f5-486e-8399-d7f67125bc15'
	 and intakeserviceid ='47ce4f4b-18dc-4f91-a43a-44739bab27b5'
	 and activeflag = 1;

update cjams.personrole   
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-44195'
where personroleid  = 'abb92de4-cb52-47fd-8b76-f1a5490249c2'
	 and intakeserviceid ='47ce4f4b-18dc-4f91-a43a-44739bab27b5'
	 and activeflag = 1;

update cjams.actorrelationship 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-44195'
where actorrelationshipid = 'fbb3d0dd-c40d-41f8-b25c-2031c29b06bb'
	 and intakeserviceid ='47ce4f4b-18dc-4f91-a43a-44739bab27b5'
	 and activeflag = 1;

update personprogramarea 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-44195' 
where personprogramid = '4fa42289-00ae-4bba-aa22-a64047d70216'
	 and activeflag = 1;

update personroletype 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-44195' 
where personroletypeid = 'f20c2ff0-7f99-4e96-b9aa-9cb9a4fb39bb';