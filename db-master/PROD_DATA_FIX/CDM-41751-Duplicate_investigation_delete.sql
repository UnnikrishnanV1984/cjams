/*
   Issue Description: CDM-41751
   Category/ Module  : Dashboard
   Root cause: User wants to remove CPS-IR case #241022874469:This is a duplicate from intake #I241013092374. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*
select * from intakeservicerequest i where servicerequestnumber in ('241022874469','241022874468');
--intakeserviceid: 5f2236d2-151c-4cdc-8a5b-29a094641e77, intakenumber = 'I241013092374'
*/
update 
   intakeservicerequest
set activeflag = 0, 
   updatedby = 'CDM-41751',
   updatedon = now() 
where 
servicerequestnumber = '241022874469';


update 
   personprogramarea 
set
  activeflag = 0,  
  updatedby = 'CDM-41751',
  updatedon = now() 
where objectid = '5f2236d2-151c-4cdc-8a5b-29a094641e77';


update 
   caseassignment
set
  activeflag = 0,  
  updatedby = 'CDM-41751',
  updatedon = now() 
where objectid = '5f2236d2-151c-4cdc-8a5b-29a094641e77';

update 
  routing
set
  activeflag = 0,  
  updatedby = 'CDM-41751',
  updatedon = now() 
where objectid = '5f2236d2-151c-4cdc-8a5b-29a094641e77' and activeflag = 1;



/*select * from intakeservicerequestdispositioncode
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77'
and activeflag = 1;*/

update 
intakeservicerequestdispositioncode
set 
	activeflag = 0,  
  updatedby = 'CDM-41751',
  updatedon = now() 
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77'
and activeflag = 1;

/*select intakenumber , intakeserviceid , servicecaseid , *
from actor
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77'
and activeflag = 1;*/

update 
actor
set 
  activeflag = 0,  
  updatedby = 'CDM-41751',
  updatedon = now() 
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77'
and activeflag = 1;




/*select intakenumber , intakeserviceid , servicecaseid , *
from intakeservicerequestactor i
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77'
and activeflag = 1;*/
update 
intakeservicerequestactor
set 
  activeflag = 0,  
  updatedby = 'CDM-41751',
  updatedon = now() 
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77'
and activeflag = 1;


/*select intakenumber , intakeserviceid , servicecaseid , *
from personrole
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77'
and activeflag = 1*/

update 
personrole
set 
  activeflag = 0,  
  updatedby = 'CDM-41751',
  updatedon = now() 
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77'
and activeflag = 1;
