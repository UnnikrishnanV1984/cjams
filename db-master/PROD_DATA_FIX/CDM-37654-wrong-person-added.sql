/*
   Issue Description: CDM-37654 - Wrong person added
   
   Root cause: User Error. There are two active CPS IR cases connected with Client ID # 202819588 (Franklin R Avila).
   Case#: 241021916453 (intakeserviceid: 64309bd0-e4d3-4c55-a703-102c2c3b22b7)
   Fix: As requested by the user removed  the Person 202819588 (d7210255-a26b-425c-90f5-a7b6f66763f1)
*/

select * from intakeservicerequestactor 
	where personid = 'd7210255-a26b-425c-90f5-a7b6f66763f1' 
		and intakeserviceid = '64309bd0-e4d3-4c55-a703-102c2c3b22b7'
		and activeflag = 1;

-- UPDATE cjams.intakeservicerequestactor
-- SET activeflag=1, updatedon='2024-03-07 10:48:43.685', updatedby='c132839a-76e5-498d-a8bd-306591287fc4'
-- WHERE intakeservicerequestactorid='d66fe599-6cd1-4f3e-9293-c00de7ee954a'::uuid and activeflag = 1;
		
update cjams.intakeservicerequestactor  
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37654'
	where intakeservicerequestactorid='d66fe599-6cd1-4f3e-9293-c00de7ee954a'::uuid
		and activeflag = 1;

select * from actor where personid = 'd7210255-a26b-425c-90f5-a7b6f66763f1' and intakeserviceid = '64309bd0-e4d3-4c55-a703-102c2c3b22b7' and activeflag = 1;

-- UPDATE cjams.actor
-- SET activeflag=1, updatedon='2024-03-07 10:48:43.685', updatedby='c132839a-76e5-498d-a8bd-306591287fc4'
-- WHERE actorid='3f7c2018-f3f6-4cdf-b289-f0defada6687'::uuid;

update cjams.actor 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37654'
	where actorid='3f7c2018-f3f6-4cdf-b289-f0defada6687'::uuid
		and activeflag = 1;

select personroleid,activeflag,updatedon,updatedby  from personrole 
	where personid = 'd7210255-a26b-425c-90f5-a7b6f66763f1' 
		and intakeserviceid = '64309bd0-e4d3-4c55-a703-102c2c3b22b7'
		and activeflag = 1;

-- UPDATE cjams.personrole
-- SET activeflag=1, updatedon='2024-03-07 10:48:43.685', updatedby='c132839a-76e5-498d-a8bd-306591287fc4'
-- WHERE personroleid='79f236e3-4ad0-47da-ada5-a43de099cfb5'::uuid;

update cjams.personrole 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37654'
	where personroleid='79f236e3-4ad0-47da-ada5-a43de099cfb5'::uuid
		and activeflag = 1;

select personroletypeid,activeflag,updatedon,updatedby  from personroletype 
	where personroletypeid='28ee6574-722d-46d6-b2e7-3bdaf19ca651'
		and activeflag = 1;

-- UPDATE cjams.personroletype
-- SET activeflag=1, updatedon='2024-03-07 10:47:56.285', updatedby='c132839a-76e5-498d-a8bd-306591287fc4'
-- WHERE personroletypeid='28ee6574-722d-46d6-b2e7-3bdaf19ca651'::uuid;

update cjams.personroletype 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37654'
	where personroletypeid='28ee6574-722d-46d6-b2e7-3bdaf19ca651'::uuid
		and activeflag = 1;

select actorrelationshipid,activeflag,updatedon,updatedby  from actorrelationship 
	where intakeservicerequestactorid='d66fe599-6cd1-4f3e-9293-c00de7ee954a'::uuid
		and activeflag = 1;

-- UPDATE cjams.actorrelationship
-- SET activeflag=1, updatedon='2024-03-07 10:47:56.285', updatedby='c132839a-76e5-498d-a8bd-306591287fc4'
-- WHERE actorrelationshipid='afe6a27b-18ab-4b3e-aa63-b14df10145a2'::uuid;

update cjams.actorrelationship 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37654'
	where actorrelationshipid='afe6a27b-18ab-4b3e-aa63-b14df10145a2'::uuid
		and activeflag = 1;
		
select activeflag,updatedon,updatedby from cjams.personprogramarea
	where personid = 'd7210255-a26b-425c-90f5-a7b6f66763f1'
		and objectid = '64309bd0-e4d3-4c55-a703-102c2c3b22b7'
		and activeflag = 1;

-- UPDATE cjams.personprogramarea
-- SET activeflag=1, updatedon='2024-03-07 10:47:56.600', updatedby='c132839a-76e5-498d-a8bd-306591287fc4' where where personid = 'd7210255-a26b-425c-90f5-a7b6f66763f1'
-- 		and objectid = '64309bd0-e4d3-4c55-a703-102c2c3b22b7';

update cjams.personprogramarea 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37654'
	where personid = 'd7210255-a26b-425c-90f5-a7b6f66763f1'
		and objectid = '64309bd0-e4d3-4c55-a703-102c2c3b22b7'
		and activeflag = 1;