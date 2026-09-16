-- CDM-41283 -  remove Duplicate Cases
/*
-- Issue Description: 
There have been duplicates created for the same case#241022874468

Client ID: 203937507 
-- Category/ Module: Documents (Case Document Management) 
-- Root cause: CPS IR cases and the intake is connected to CPS IR# 241022874468, Both CPS IR cases are having the same data entered.
                Intake # I241013092374
                CPS IR# 241022874468
                CPS IR# 241022874469 intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77'
-- Fix Provided: Datafix has been promoted for duplicate case
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/
/*
select * from intakeservicerequestsdm
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77' and activeflag = 1;
*/

update intakeservicerequestsdm
set activeflag = 0, updatedby = 'CDM-41283', updatedon = now() 
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77';

/*
select * from intakeservicerequest
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77' and activeflag = 1;
*/

update intakeservicerequest
set activeflag = 0, updatedby = 'CDM-41283', updatedon = now() 
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77';

/*
select * from intakeservicerequestdispositioncode
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77' and activeflag = 1;
*/

update intakeservicerequestdispositioncode
set activeflag = 0, updatedby = 'CDM-41283', updatedon = now() 
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77';


/*
select * from caseassignment
where objectid = '5f2236d2-151c-4cdc-8a5b-29a094641e77' and activeflag = 0;
*/


update caseassignment
set activeflag = 0, updatedby = 'CDM-41283', updatedon = now() 
where objectid = '5f2236d2-151c-4cdc-8a5b-29a094641e77';


--select * from personprogramarea
--where objectid = '5f2236d2-151c-4cdc-8a5b-29a094641e77' and activeflag = 0;

update personprogramarea
set activeflag = 0, updatedby = 'CDM-41283', updatedon = now() 
where objectid = '5f2236d2-151c-4cdc-8a5b-29a094641e77';


/*
select * from actor
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77' and activeflag = 1;
*/

update actor
set activeflag = 0, updatedby = 'CDM-41283', updatedon = now() 
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77';


/*select * from intakeservicerequestactor
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77' and activeflag = 1;*/

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CDM-41283', updatedon = now() 
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77';


/*select * from personrole
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77' and activeflag = 1;*/

update personrole
set activeflag = 0, updatedby = 'CDM-41283', updatedon = now() 
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77';


/*select * from actorrelationship
where intakeservicerequestactorid
in (select intakeservicerequestactorid from intakeservicerequestactor
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77'
)
and activeflag = 1;*/

update actorrelationship
set activeflag = 0, updatedby = 'CDM-41283', updatedon = now() 
where intakeservicerequestactorid
in (select intakeservicerequestactorid from intakeservicerequestactor
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77'
)
and activeflag = 1;


/*
select * from personroletype
where personroleid
in ( select personroleid from personrole
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77' )
and activeflag = 1;
*/

update personroletype
set activeflag = 0, updatedby = 'CDM-41283', updatedon = now() 
where personroleid
in ( select personroleid from personrole
where intakeserviceid = '5f2236d2-151c-4cdc-8a5b-29a094641e77' )
and activeflag = 1;


/*
select * from routing
where objectid = '5f2236d2-151c-4cdc-8a5b-29a094641e77'
and activeflag = 1 ;
*/

update routing
set activeflag = 0, updatedby = 'CDM-41283', updatedon = now() 
where objectid = '5f2236d2-151c-4cdc-8a5b-29a094641e77'
and activeflag = 1 ;