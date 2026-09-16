/*
Issue Description: 241022410583:Incorrect person/alleged maltreator selected in AR 241022410583. JOSHUA ARON TWIGG (CJAMS PID 192920) must be removed from the case and replaced with Joshua Daniel Twigg (CJAMS PID 204033377). 
Category/ Module: Profile
Root cause: User Error/ SSA approval, incorrect person was selected for the case AR 241022410583.
Fix provided: Yes, wrote DB query.
Code fix ticket#: N/A
Reason why no related code fix: this is data issue.
*/

/*
--wrong person: JOSHUA ARON TWIGG (CJAMS PID 192920)
select * from person u where cjamspid = '192920';
personid: f0722220-e108-4eb6-9981-96d777724a79
actorid: 8075db74-2634-4db9-8d64-a3a6161ee9fc for cpscase: ce33bae0-cb44-4f4d-b9ed-daa6d2f4ecd3

-- right person:  Joshua Daniel Twigg (CJAMS PID 204033377)
select * from person u where cjamspid = '204033377';
personid: 88c9b620-6cea-458e-be18-2510e8c287ce

*/
/*
select * from actor 
where personid = 'f0722220-e108-4eb6-9981-96d777724a79' and activeflag =1 
and intakeserviceid = 'ce33bae0-cb44-4f4d-b9ed-daa6d2f4ecd3';
*/

-- update wrong person with right person
/*
select servicecaseid,personid,intakenumber,intakeserviceid,activeflag,updatedby,* from intakeservicerequestactor 
where personid = 'f0722220-e108-4eb6-9981-96d777724a79' 
and intakeserviceid  = 'ce33bae0-cb44-4f4d-b9ed-daa6d2f4ecd3'
and activeflag = 1;
*/

update intakeservicerequestactor 
set updatedby = 'CJAMS-61382',
	updatedon = now(),
	personid = '88c9b620-6cea-458e-be18-2510e8c287ce'-- right
where personid = 'f0722220-e108-4eb6-9981-96d777724a79' --wrong
and intakeserviceid  = 'ce33bae0-cb44-4f4d-b9ed-daa6d2f4ecd3'
and activeflag = 1;

/*select servicecaseid,personid,intakenumber,intakeserviceid,activeflag,updatedby,* from actor 
where personid = '88c9b620-6cea-458e-be18-2510e8c287ce' 
and intakeserviceid  = 'ce33bae0-cb44-4f4d-b9ed-daa6d2f4ecd3'
and activeflag = 1;
*/

update actor 
set updatedby = 'CJAMS-61382',
	updatedon = now(),
	personid = '88c9b620-6cea-458e-be18-2510e8c287ce'-- right
where personid = 'f0722220-e108-4eb6-9981-96d777724a79' --wrong
and intakeserviceid  = 'ce33bae0-cb44-4f4d-b9ed-daa6d2f4ecd3'
and activeflag = 1;

/*
select * from personprogramarea p 
where personid = 'f0722220-e108-4eb6-9981-96d777724a79' --wrong
and objectid  = 'ce33bae0-cb44-4f4d-b9ed-daa6d2f4ecd3'
and activeflag = 1;
*/

update cjams.personprogramarea 
	set personid = '88c9b620-6cea-458e-be18-2510e8c287ce',-- right
		updatedon = now(),
		updatedby = 'CJAMS-61382'
where personid = 'f0722220-e108-4eb6-9981-96d777724a79' --wrong
and objectid  = 'ce33bae0-cb44-4f4d-b9ed-daa6d2f4ecd3'
and activeflag = 1;

/*
select * from actorrelationship a where intakeserviceid = 'ce33bae0-cb44-4f4d-b9ed-daa6d2f4ecd3' and activeflag=1
and person1id = 'f0722220-e108-4eb6-9981-96d777724a79';

select * from actorrelationship a where intakeserviceid = 'ce33bae0-cb44-4f4d-b9ed-daa6d2f4ecd3' and activeflag=1
and person1id = 'f0722220-e108-4eb6-9981-96d777724a79';

select * from actorrelationship a where intakeserviceid = 'ce33bae0-cb44-4f4d-b9ed-daa6d2f4ecd3' and activeflag=1
and person2id = 'f0722220-e108-4eb6-9981-96d777724a79';

*/

update actorrelationship
set person1id = '88c9b620-6cea-458e-be18-2510e8c287ce',
	updatedby = 'CJAMS-61382',
	updatedon =  now()
where intakeservicerequestactorid in ('d80b9103-9cb9-44cb-b902-97be3f759ddf',
'e976445f-01e6-4346-9196-691c8d6517e7')
and activeflag =1
and person1id = 'f0722220-e108-4eb6-9981-96d777724a79';

update actorrelationship
set person2id  = '88c9b620-6cea-458e-be18-2510e8c287ce',
	updatedby = 'CJAMS-61382',
	updatedon =  now()
where intakeservicerequestactorid in ('d80b9103-9cb9-44cb-b902-97be3f759ddf',
'e976445f-01e6-4346-9196-691c8d6517e7')
and activeflag =1
and person2id  = 'f0722220-e108-4eb6-9981-96d777724a79';