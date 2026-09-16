/*
   Issue Description: CIDM-10226
    Category/ Module  : case close
   Root cause: User requested to remove data and close the case 
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/

--select * from person where cjamspid ='204069547' -- persion id =b106e7e4-d8e1-4ce5-8b5b-8871979a3fcb -- actor id = 7c6bd515-31cb-4b65-a28c-ccdcd1febcdf
--select * from person where cjamspid ='204069538' -- persion id =c42fe563-aefc-462a-92a0-b3e80872f877 -- actor id = 2cd3cc9f-2b52-44da-ba06-0a5241c2e6bc 
--
--select * from actor where personid ='c42fe563-aefc-462a-92a0-b3e80872f877' and servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22'
--
--select * from intakeservicerequestactor where actorid ='7c6bd515-31cb-4b65-a28c-ccdcd1febcdf' -- 8c14d1f7-ba6e-4c83-b47e-27d97dea10ce
--select * from intakeservicerequestactor where actorid ='2cd3cc9f-2b52-44da-ba06-0a5241c2e6bc' -- ('3a03b77e-15d3-4882-a76c-3ee456a950dc','25df4f0e-50ea-4d35-b2d5-c7af9a267840')
--
--select * from personrole where personid ='b106e7e4-d8e1-4ce5-8b5b-8871979a3fcb' and servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' -- 2810dfdd-3c38-49db-9e86-664e22da5702
--select * from personrole where personid ='c42fe563-aefc-462a-92a0-b3e80872f877' and servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' -- 5f03ee3d-d0b1-4d86-a186-b1f3ed60dfb9
--
--select * from actorrelationship where intakeservicerequestactorid ='8c14d1f7-ba6e-4c83-b47e-27d97dea10ce' --4436f47f-0b27-4b7b-98df-3ab954438462
--select * from actorrelationship where intakeservicerequestactorid in ('3a03b77e-15d3-4882-a76c-3ee456a950dc','25df4f0e-50ea-4d35-b2d5-c7af9a267840') --2e43735b-3310-41f0-8285-5cd0e4ea6f06
--
--select * from personprogramarea where personid ='b106e7e4-d8e1-4ce5-8b5b-8871979a3fcb' --9cafeca9-761c-4dbd-b0aa-9228528f5208
--select * from personprogramarea where personid ='c42fe563-aefc-462a-92a0-b3e80872f877' --a3975290-7aa2-4e36-b17d-c83b790f3826

-- actor

update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CIDM-10226'
where actorid ='7c6bd515-31cb-4b65-a28c-ccdcd1febcdf';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CIDM-10226'
where intakeservicerequestactorid = '8c14d1f7-ba6e-4c83-b47e-27d97dea10ce';

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CIDM-10226'
where personroleid  = '2810dfdd-3c38-49db-9e86-664e22da5702';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CIDM-10226'
where intakeservicerequestactorid = '4436f47f-0b27-4b7b-98df-3ab954438462';


update cjams.personprogramarea set activeflag =0, updatedon = now(),
updatedby = 'CIDM-10226'
where personprogramid ='9cafeca9-761c-4dbd-b0aa-9228528f5208';

----------------------------
update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CIDM-10226'
where actorid ='2cd3cc9f-2b52-44da-ba06-0a5241c2e6bc';

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CIDM-10226'
where intakeservicerequestactorid in ('3a03b77e-15d3-4882-a76c-3ee456a950dc','25df4f0e-50ea-4d35-b2d5-c7af9a267840');

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CIDM-10226'
where personroleid  = '5f03ee3d-d0b1-4d86-a186-b1f3ed60dfb9';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CIDM-10226'
where intakeservicerequestactorid = '2e43735b-3310-41f0-8285-5cd0e4ea6f06';


update cjams.personprogramarea set activeflag =0, updatedon = now(),
updatedby = 'CIDM-10226'
where personprogramid ='a3975290-7aa2-4e36-b17d-c83b790f3826';



-------------------------------------
--Contacts
--select * from progressnote where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and EXTRACT(YEAR FROM contactdate) = 2025 and activeflag =1;
--
--select * from progressnotedetail where progressnoteid in (select progressnoteid from progressnote where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and EXTRACT(YEAR FROM contactdate) = 2025);
--
--select activeflag, * from progressnote_audit_detail where progressnoteid in (select progressnoteid from progressnote where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22'  and EXTRACT(YEAR FROM contactdate) = 2025);
--
--select * from contactparticipant where  progressnoteid in (select progressnoteid from progressnote where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and EXTRACT(YEAR FROM contactdate) = 2025);
-----

update progressnote set activeflag=0, updatedby ='CIDM-10226', updatedon = now()
where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and  EXTRACT(YEAR FROM contactdate) = 2025 and activeflag =1;

update progressnotedetail set activeflag=0, updatedby ='CIDM-10226', updatedon = now() 
where progressnoteid in (select progressnoteid from progressnote where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and EXTRACT(YEAR FROM contactdate) = 2025)
and activeflag =1;

update progressnote_audit_detail set activeflag=0, updatedby ='CIDM-10226', updatedon = now() 
where progressnoteid in (select progressnoteid from progressnote where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22'  and EXTRACT(YEAR FROM contactdate) = 2025)
and activeflag=1;

update  contactparticipant set  activeflag=0, updatedby ='CIDM-10226', updatedon = now() 
where  progressnoteid in (select progressnoteid from progressnote where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and EXTRACT(YEAR FROM contactdate) = 2025)
and activeflag=1;

--------------------------------------
-- case assignment
--select * from caseassignment where caseassignmentid in ('0a137ddf-4ae1-4536-a097-ee1b2e606b16','70b5434c-407a-4471-a4db-9ea7fb1afa99')

update caseassignment set activeflag = 0, updatedon = now(), updatedby = 'CIDM-10226' where caseassignmentid in ('0a137ddf-4ae1-4536-a097-ee1b2e606b16','70b5434c-407a-4471-a4db-9ea7fb1afa99') and activeflag =1;

-----------------------------------------

--Assessments

--select * from assessment where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = '2025'
--
--select * from assessmentactor where assessmentid in (select assessmentid from assessment where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = 2025)
--
--select * from assessmentcomments where assessmentid in (select assessmentid from assessment where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = 2025)
--
--select * from assessment_history  where assessmentid in (select assessmentid from assessment where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = 2025)
--
--select * from routing where objectid::uuid in  (select assessmentid from assessment where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = 2025) and eventcode= 'ASST' and activeflag =1;
--
--select * from userprofile where email='sarah.hardy1@maryland.gov'

update assessment 
	set activeflag=0, 
		updatedby ='1f5d2877-a717-4eb7-8ad0-42fa47da39b2', 
		updatedon =now() 
	where  servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = '2025'
		and activeflag=1;
		
update assessmentactor 
	set activeflag=0, 
	updatedby ='1f5d2877-a717-4eb7-8ad0-42fa47da39b2', 
	updatedon =now() 
where assessmentid in (select assessmentid from assessment where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = '2025')
		and activeflag=1;

update assessmentcomments 
	set activeflag=0, 
		updatedby ='1f5d2877-a717-4eb7-8ad0-42fa47da39b2', 
		updatedon =now() 
	where assessmentid in (select assessmentid from assessment where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = '2025')
		and activeflag=1;

update assessment_history 
	set activeflag=0, 
		updatedby ='1f5d2877-a717-4eb7-8ad0-42fa47da39b2', 
		updatedon =now() 
	where assessmentid in (select assessmentid from assessment where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = '2025')
		and activeflag=1;

update routing 
	set activeflag=0,
		updatedby ='1f5d2877-a717-4eb7-8ad0-42fa47da39b2', 
		updatedon =now()	
	where objectid::uuid in  (select assessmentid from assessment where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = '2025') 
		and eventcode= 'ASST' and activeflag =1;

	-------------------------------------
	
	--Documents
	
--	select * from documentproperties where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = '2025'
--	
--	select * from documentattachment where documentpropertiesid in (select documentpropertiesid from documentproperties where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = '2025')
--	
update documentproperties
	set
	activeflag = 0,
	updatedby = 'CIDM-10226',
	updatedon = now()
where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = '2025'
and activeflag = 1;

update documentattachment
	set
	activeflag = 0,
	updatedby = 'CIDM-10226',
	updatedon = now()
where documentpropertiesid in (select documentpropertiesid from documentproperties where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22' and extract(year from insertedon) = '2025')
and activeflag = 1;
	
--------------------------------
--case close

--select * from servicecasedisposition where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22'

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = now() , updatedby = 'CIDM-10226',updatedon = now() 
WHERE servicecaseid = '8cfad433-ccec-4b6a-8dfc-4e78521ccf22';


INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('8cfad433-ccec-4b6a-8dfc-4e78521ccf22'::uuid, '2018-03-28 00:00:00', 'Closed', 'Closed', '', '2018-03-28 00:00:00', 1, 'CIDM-10226', now(), 'CIDM-10226', now());


INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest)
VALUES('SCDR', '1f5d2877-a717-4eb7-8ad0-42fa47da39b2',
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='8cfad433-ccec-4b6a-8dfc-4e78521ccf22'
		and updatedby ='CIDM-10226' 
		order by insertedon desc limit 1), 
	16, 1, 'CIDM-10226', now(), 'CIDM-10226', now(), true);
