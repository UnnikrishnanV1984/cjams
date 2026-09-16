/*
  Issue Description:  CDM-39840
   Category/ Module  :  Application
   Root cause: user requested to remove the person card from others tab
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-39840'
where actorid ='3a4fb73c-ab74-4f6e-af62-f6bdb6d9e66b' and intakeserviceid ='2f3c9937-bc3a-43cd-8d6b-e3bd4574c29c' and activeflag =1;

update cjams.intakeservicerequestactor  
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-39840'
where intakeservicerequestactorid = 'e84f20c7-da5d-4947-8a14-fceb82d1e644' and activeflag =1;

update cjams.personrole   
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-39840'
where personroleid  = '22d96df7-5ec2-4fc0-90d3-8093e52cd66d' and activeflag =1;

update cjams.actorrelationship 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-39840'
where actorrelationshipid = 'e154bf75-352b-4541-9aff-044cc0a6ea96' and activeflag =1;


update personprogramarea 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-39840' 
where personprogramid = 'cc8da512-30a3-46ff-89ae-aec2c7daa964' and activeflag =1;

update personroletype 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-39840' 
where personroletypeid = 'd3f179d0-1825-441f-95b1-802b656952ee' and activeflag =1;


