/*
   Issue Description: CDM-36992

   Tables: 
      intakedastatus :: intakenumber
      routing :: objectid
      intakedastaging :: intakenumber
      intakesnapshot :: intakenumber
      intakeservicerequest :: intakenumber
      intakeservicerequestactor :: intakenumber
   Root cause: The Intake has no detail information in it. Removed the Intake # I202100113509 as requested.
   Fix provided: Data fix provided to remove intake.
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

--Backup
select * from intakedastatus where intakedastatusid='0c2b33fe-1bdd-42af-a25c-b7c1d5476de2'::uuid and intakenumber = 'I202100113509' and activeflag = 1;

-- UPDATE cjams.intakedastatus
-- SET activeflag=1, updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 15:23:43.498' WHERE intakedastatusid='0c2b33fe-1bdd-42af-a25c-b7c1d5476de2'::uuid and intakenumber = 'I202100113509' and activeflag = 1;

--Update
Update intakedastatus set 
updatedby = 'CDM-36992', updatedon = now(),
activeflag =0
WHERE intakedastatusid='0c2b33fe-1bdd-42af-a25c-b7c1d5476de2'::uuid and intakenumber = 'I202100113509' and activeflag = 1;


--Backup
select updatedby,updatedon,activeflag,id,intakenumber from intakedastaging where id=8876684 and intakenumber='I202100113509' and activeflag = 1;

-- UPDATE cjams.intakedastaging
-- SET updatedby='fc251376-8745-4381-a750-6a617c748678', updatedon='2024-02-05 12:19:31.887', activeflag=1, intakenumber='I202100113509'
-- WHERE id=8876684 and intakenumber = 'I202100113509' and activeflag = 1;

--Update
Update intakedastaging set 
updatedby = 'CDM-36992', updatedon = now(),
activeflag =0
WHERE id=8876684 and intakenumber = 'I202100113509' and activeflag = 1;


--Backup
select activeflag,updatedby,updatedon,intakeservicerequestactorid from intakeservicerequestactor where intakenumber = 'I202100113509';

-- UPDATE cjams.intakeservicerequestactor
-- SET activeflag=1, updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 15:50:34.488'
-- WHERE intakeservicerequestactorid='c3f1ae0a-dfae-4838-a885-869ad0c22cda';
-- UPDATE cjams.intakeservicerequestactor
-- SET activeflag=1, updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 15:58:57.193'
-- WHERE intakeservicerequestactorid='8d225fd8-9cf4-4c70-894e-81a32f9dc2e0';
-- UPDATE cjams.intakeservicerequestactor
-- SET activeflag=1, updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 15:53:59.005'
-- WHERE intakeservicerequestactorid='342ca161-656d-4860-804f-fb3aafd90dac';

--Update
update intakeservicerequestactor set activeflag = 0, updatedon = now(), updatedby = 'CDM-36992' where intakenumber = 'I202100113509';

--Backup
select updatedby,updatedon,activeflag,actorid from actor where intakenumber='I202100113509';

--UPDATE cjams.actor
--SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 15:50:34.488', activeflag=1
--WHERE actorid='13fc2755-43ba-466c-99d1-783e9adcbde8';
--UPDATE cjams.actor
--SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 15:53:59.005', activeflag=1
--WHERE actorid='6ff45b29-8905-4a39-96e9-4a3ea6433f2e';
--UPDATE cjams.actor
--SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 15:58:57.193', activeflag=1
--WHERE actorid='bb742128-9fef-4560-a129-0432e83fecf0';

--Update
UPDATE cjams.actor
SET updatedby = 'CDM-36992',updatedon = now(),activeflag =0
where intakenumber='I202100113509';

--Backup
select updatedby,updatedon,activeflag,intakeservicerequestactorid,actorrelationshipid from actorrelationship where intakenumber='I202100113509';
--UPDATE cjams.actorrelationship
--SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 15:50:34.488', activeflag=1, intakeservicerequestactorid='c3f1ae0a-dfae-4838-a885-869ad0c22cda'
--WHERE actorrelationshipid='8238b154-1415-4817-9b11-c87f36bb2187';
--UPDATE cjams.actorrelationship
--SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 15:53:59.005', activeflag=1, intakeservicerequestactorid='342ca161-656d-4860-804f-fb3aafd90dac'
--WHERE actorrelationshipid='067be1e6-4a62-48d9-897d-603efce0737c';
--UPDATE cjams.actorrelationship
--SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 15:58:57.193', activeflag=1, intakeservicerequestactorid='8d225fd8-9cf4-4c70-894e-81a32f9dc2e0'
--WHERE actorrelationshipid='b7c93f1e-a58c-4f61-81d5-d53b89785430';

--Update
UPDATE cjams.actorrelationship
SET updatedby = 'CDM-36992',updatedon = now(),activeflag =0
where intakenumber='I202100113509';

--Backup
select updatedby,updatedon,activeflag,personroleid from personrole where intakenumber='I202100113509';

--UPDATE cjams.personrole
--SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 20:50:34.488', activeflag=1
--WHERE personroleid='033f8484-de90-4b19-b049-ce60ad0354c1';
--UPDATE cjams.personrole
--SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 20:53:59.005', activeflag=1
--WHERE personroleid='41e8a98b-40d2-4077-bea5-be1968b37e77';
--UPDATE cjams.personrole
--SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 20:58:57.193', activeflag=1
--WHERE personroleid='bd119a89-6f4c-4797-ad39-be412b48a9ee';

--Update
UPDATE cjams.personrole
SET updatedby = 'CDM-36992',updatedon = now(),activeflag =0
where intakenumber='I202100113509';

--Backup
select updatedby,updatedon,activeflag,personroletypeid from personroletype where 
personroletypeid in ('44026054-7c5c-4d61-92ea-6df544550fc1','a4bebe6c-9b52-4c58-8d47-5877fca40fc9','f4f8f6b2-58db-48e2-98de-db9f2b7e7ff4');

--UPDATE cjams.personroletype
--SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 15:50:34.488', activeflag=1
--WHERE personroletypeid='f4f8f6b2-58db-48e2-98de-db9f2b7e7ff4';
--UPDATE cjams.personroletype
--SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 15:53:59.005', activeflag=1
--WHERE personroletypeid='a4bebe6c-9b52-4c58-8d47-5877fca40fc9';
--UPDATE cjams.personroletype
--SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-01-04 15:58:57.193', activeflag=1
--WHERE personroletypeid='44026054-7c5c-4d61-92ea-6df544550fc1';

--Update
UPDATE cjams.personroletype
SET updatedby = 'CDM-36992',updatedon = now(),activeflag =0
where personroletypeid in ('44026054-7c5c-4d61-92ea-6df544550fc1','a4bebe6c-9b52-4c58-8d47-5877fca40fc9','f4f8f6b2-58db-48e2-98de-db9f2b7e7ff4');