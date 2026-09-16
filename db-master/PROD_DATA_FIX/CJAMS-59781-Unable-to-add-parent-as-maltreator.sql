/*
-- Issue Description: 
--  Trying to add mother as an alleged maltreator for neglect, case was overridden to add neglect as as finding. Persons tab not allowing mother to have the role of alleged maltreator.
-- Category/ Module: Person profile
-- Root cause: wrong actorid was mapped
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- case
select * from actor where personid = 'cf015057-e9d1-4ac9-8141-62d4a86deaa4' 
and intakeserviceid = '7d0ba538-9c4e-4b5c-a1fe-230306bdf3bf'
and activeflag=1;

select * from intakeservicerequestactor where personid = 'cf015057-e9d1-4ac9-8141-62d4a86deaa4' and intakeserviceid = '7d0ba538-9c4e-4b5c-a1fe-230306bdf3bf'
and activeflag=1;

--intake level
select * from actor where intakenumber = 'I251013247354' and personid = 'cf015057-e9d1-4ac9-8141-62d4a86deaa4';
select * from intakeservicerequestactor where  personid = 'cf015057-e9d1-4ac9-8141-62d4a86deaa4' and activeflag=1
and intakenumber = 'I251013247354';
*/

update actor 
set activeflag = 0,
	updatedby = 'CJAMS-59781',
	updatedon = now() 
where actorid = 'a8ca4087-864d-4042-baf6-124abd61f63a'--duplicate
and activeflag  = 1;

update intakeservicerequestactor 
set updatedby = 'CJAMS-59781',
	actorid = '722ea23e-585f-49c6-8f9a-0f732d1e1a9d',
	updatedon = now() 
where personid = 'cf015057-e9d1-4ac9-8141-62d4a86deaa4' and activeflag =1
and intakeserviceid ='7d0ba538-9c4e-4b5c-a1fe-230306bdf3bf' and actorid = 'a8ca4087-864d-4042-baf6-124abd61f63a';
