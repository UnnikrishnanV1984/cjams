/*
   Issue Description: CDM-37935
   Root cause: User wants to remove the intake # I241012088138.
   Fix provided: Data fix provided to remove the intake.
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

-- Backup
select * from intakedastatus where intakedastatusid='1939694a-de0f-46c4-98e6-944005b51680'::uuid and intakenumber = 'I241012088138' and activeflag = 1;
-- UPDATE cjams.intakedastatus
-- SET activeflag=1, updatedby='28472a29-7cbc-41d9-99eb-f975a076179c', updatedon='2024-03-21 02:09:06.094'
-- WHERE intakedastatusid='1939694a-de0f-46c4-98e6-944005b51680';

-- Update
Update intakedastatus set 
updatedby = 'CDM-37935', updatedon = now(),
activeflag =0
WHERE intakedastatusid='1939694a-de0f-46c4-98e6-944005b51680'::uuid and intakenumber = 'I241012088138' and activeflag = 1;

-- Backup
select updatedby,updatedon,activeflag,id,intakenumber from intakedastaging where id=3684316 and intakenumber='I241012088138' and activeflag = 1;
-- UPDATE cjams.intakedastaging
-- SET updatedby='28472a29-7cbc-41d9-99eb-f975a076179c', updatedon='2024-03-21 02:09:06.094', activeflag=1, intakenumber='I241012088138'
-- WHERE id=9186935;

-- Update
Update intakedastaging set 
updatedby = 'CDM-37935', updatedon = now(),
activeflag =0
WHERE id=9186935 and intakenumber='I241012088138' and activeflag = 1;

-- No data
select activeflag,updatedby,updatedon,intakeservicerequestactorid from intakeservicerequestactor where intakenumber = 'I241012088138';

-- No data
select updatedby,updatedon,activeflag,actorid from actor where intakenumber='I241012088138';

-- No data
select updatedby,updatedon,activeflag,intakeservicerequestactorid,actorrelationshipid from actorrelationship where intakenumber='I241012088138';

-- No data
select updatedby,updatedon,activeflag,personroleid from personrole where intakenumber='I241012088138';

-- No data
select routingid, objectid, activeflag , updatedby, updatedon from routing where objectid in ('I241012088138') and activeflag = 1 ;
	
-- Backup
-- No data
select intakenumber, activeflag , updatedby, updatedon from intakesnapshot where intakenumber in ('I241012088138') and activeflag = 1 ;
