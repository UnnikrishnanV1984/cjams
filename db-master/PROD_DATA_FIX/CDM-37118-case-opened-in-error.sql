/*
   Issue Description: CDM-37118
   Root cause: The intake has not bee submitted for supervisor approval. Requested to remove the Intake # I221010243434.
   Fix provided: Data fix provided to remove intake.
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

--Backup
select * from intakedastatus where intakedastatusid='f4e1445f-e861-4ad7-ba2d-304aa576f59f'::uuid and intakenumber = 'I221010243434' and activeflag = 1;

-- UPDATE cjams.intakedastatus
-- SET activeflag=1, updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2022-02-18 13:45:15.516' 
-- WHERE intakedastatusid='f4e1445f-e861-4ad7-ba2d-304aa576f59f'::uuid and intakenumber = 'I221010243434' and activeflag = 1;

--Update
Update intakedastatus set 
updatedby = 'CDM-37118', updatedon = now(),
activeflag =0
WHERE intakedastatusid='f4e1445f-e861-4ad7-ba2d-304aa576f59f'::uuid and intakenumber = 'I221010243434' and activeflag = 1;


--Backup
select updatedby,updatedon,activeflag,id,intakenumber from intakedastaging where id=3684316 and intakenumber='I221010243434' and activeflag = 1;

-- UPDATE cjams.intakedastaging
-- SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2022-02-18 13:45:15.516', activeflag=1, intakenumber='I221010243434'
-- WHERE id=3684316 and intakenumber='I221010243434' and activeflag = 1;


--Update
Update intakedastaging set 
updatedby = 'CDM-37118', updatedon = now(),
activeflag =0
WHERE id=3684316 and intakenumber='I221010243434' and activeflag = 1;


--Backup
select activeflag,updatedby,updatedon,intakeservicerequestactorid from intakeservicerequestactor where intakenumber = 'I221010243434';

--Update
update intakeservicerequestactor set activeflag = 0, updatedon = now(), updatedby = 'CDM-37118' where intakenumber = 'I221010243434';

--Backup
select updatedby,updatedon,activeflag,actorid from actor where intakenumber='I221010243434';

--Update
UPDATE cjams.actor
SET updatedby = 'CDM-37118',updatedon = now(),activeflag =0
where intakenumber='I221010243434';

--Backup
select updatedby,updatedon,activeflag,intakeservicerequestactorid,actorrelationshipid from actorrelationship where intakenumber='I221010243434';

--Update
UPDATE cjams.actorrelationship
SET updatedby = 'CDM-37118',updatedon = now(),activeflag =0
where intakenumber='I221010243434';

--Backup
select updatedby,updatedon,activeflag,personroleid from personrole where intakenumber='I221010243434';

--Update
UPDATE cjams.personrole
SET updatedby = 'CDM-37118',updatedon = now(),activeflag =0
where intakenumber='I221010243434';