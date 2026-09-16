-- CDM-42708 - person role not populating
/*
-- Issue Description: 
--  people's roles do not save correctly.User am unable to save the person as all the roles I want for the person

-- Category/ Module: Document upload
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*--
select * from actor where actorid = '94013e6a-8786-46d2-816d-7c25d2b11371';
select * from actor where personid = '81692504-9302-4da0-9a0c-6fca21c80468';
select isheadofhousehold,* from intakeservicerequestactor i 
where actorid = '94013e6a-8786-46d2-816d-7c25d2b11371' and activeflag = 1;
 */
/*
select intakeserviceid , intakenumber , servicecaseid , * 
from actor i 
where actorid = '94013e6a-8786-46d2-816d-7c25d2b11371'
and activeflag  = 1;
*/

update actor 
set activeflag = 0,
	updatedby = 'CDM-42078',
	updatedon = now() 
where actorid = '94013e6a-8786-46d2-816d-7c25d2b11371'
and activeflag  = 1;

/*
select intakeserviceid , intakenumber , servicecaseid , activeflag , * 
from intakeservicerequestactor i 
where actorid = '94013e6a-8786-46d2-816d-7c25d2b11371'
and activeflag  = 1;
*/

update intakeservicerequestactor 
set activeflag = 0,
	updatedby = 'CDM-42078',
	updatedon = now() 
where actorid = '94013e6a-8786-46d2-816d-7c25d2b11371'
and activeflag  = 1;