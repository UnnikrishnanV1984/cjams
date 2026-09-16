
/*
   Issue Description: CDM-18643
   Category/ Module  : Duplicate Person remove from service request.  
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--select * from actorrelationship where intakeservicerequestactorid = '41c70183-55ce-49e4-94b8-aed5c7fa651f'	and activeflag  =1;

update actorrelationship set activeflag = 0, updatedby = 'CDM-18035', updatedon = now() where intakeservicerequestactorid in (	
	select intakeservicerequestactorid 
	from intakeservicerequestactor
	where personid = '0a907495-fe5a-472f-a5d2-8f56a4e53b8d' and intakeserviceid = '764969c4-48a9-410d-9ffb-c14bfcc7f265')	
and activeflag = 1;	

-- intakeservicerequestactor
--select * from intakeservicerequestactor where personid = '0a907495-fe5a-472f-a5d2-8f56a4e53b8d' and intakeserviceid = '764969c4-48a9-410d-9ffb-c14bfcc7f265' and activeflag =1;
		
update intakeservicerequestactor	
set activeflag = 0, updatedby = 'CDM-18035', updatedon = now()
where personid = '0a907495-fe5a-472f-a5d2-8f56a4e53b8d' and intakeserviceid = '764969c4-48a9-410d-9ffb-c14bfcc7f265' and activeflag = 1 ;
	
--actor
--select * from actor where personid = '0a907495-fe5a-472f-a5d2-8f56a4e53b8d' and intakeserviceid = '764969c4-48a9-410d-9ffb-c14bfcc7f265' and activeflag =1;
update actor
set activeflag = 0,	updatedby = 'CDM-18035', updatedon = now()
where personid = '0a907495-fe5a-472f-a5d2-8f56a4e53b8d' and intakeserviceid = '764969c4-48a9-410d-9ffb-c14bfcc7f265' and activeflag = 1 ;