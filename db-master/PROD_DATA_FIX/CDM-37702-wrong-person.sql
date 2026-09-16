/*
   Issue Description: CDM-37702 - Wrong person
   
   Root cause: User Error. Client ID # 4202481 (Robert Todd Sr.) was added to the wrong case .
   Case#: 241021910974 (intakeserviceid: 953105a9-27fa-4fa4-a196-bc29176c625e)
   Fix: As requested by the user removed  the Person 4202481 (1ca09d9f-ab87-43cb-b5a2-aeeb34a66f4c)
*/

select * from intakeservicerequestactor 
	where personid = '1ca09d9f-ab87-43cb-b5a2-aeeb34a66f4c' 
		and intakeserviceid = '953105a9-27fa-4fa4-a196-bc29176c625e'
		and activeflag = 1;

-- UPDATE cjams.intakeservicerequestactor
-- SET activeflag=1, updatedon='2024-03-08 15:27:12.452', updatedby='1b22ed17-fee6-4b52-ad10-ece560c9d6d2'
-- WHERE intakeservicerequestactorid='dbb5bf3a-3db1-48e7-865d-99612ec60db5';
-- UPDATE cjams.intakeservicerequestactor
-- SET activeflag=1, updatedon='2024-03-08 15:27:12.452', updatedby='1b22ed17-fee6-4b52-ad10-ece560c9d6d2'
-- WHERE intakeservicerequestactorid='ba9efe05-dcdb-4104-ba08-be9bb90daec7';

		
update cjams.intakeservicerequestactor  
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37702'
	where intakeservicerequestactorid in ('ba9efe05-dcdb-4104-ba08-be9bb90daec7','dbb5bf3a-3db1-48e7-865d-99612ec60db5')
		and activeflag = 1;

select * from actor where personid = '1ca09d9f-ab87-43cb-b5a2-aeeb34a66f4c' and intakeserviceid = '953105a9-27fa-4fa4-a196-bc29176c625e' and activeflag = 1;

-- UPDATE cjams.actor
-- SET activeflag=1, updatedon='2024-03-08 15:27:12.452', updatedby='1b22ed17-fee6-4b52-ad10-ece560c9d6d2'
-- WHERE actorid='e146e62b-d231-433b-a1a1-de03be5b0a13';

update cjams.actor 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37702'
	where actorid='e146e62b-d231-433b-a1a1-de03be5b0a13'
		and activeflag = 1;

select personroleid,activeflag,updatedon,updatedby  from personrole 
	where personid = '1ca09d9f-ab87-43cb-b5a2-aeeb34a66f4c' 
		and intakeserviceid = '953105a9-27fa-4fa4-a196-bc29176c625e'
		and activeflag = 1;

-- UPDATE cjams.personrole
-- SET activeflag=1, updatedon='2024-03-08 20:27:12.452', updatedby='1b22ed17-fee6-4b52-ad10-ece560c9d6d2'
-- WHERE personroleid='047ca550-00bd-4ea1-b092-d2da433782c2';

update cjams.personrole 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37702'
	where personroleid='047ca550-00bd-4ea1-b092-d2da433782c2'
		and activeflag = 1;

select personroletypeid,activeflag,updatedon,updatedby  from personroletype 
	where personroleid='047ca550-00bd-4ea1-b092-d2da433782c2'
		and activeflag = 1;

-- UPDATE cjams.personroletype
-- SET activeflag=1, updatedon='2024-03-08 15:27:12.452', updatedby='1b22ed17-fee6-4b52-ad10-ece560c9d6d2'
-- WHERE personroletypeid='a080cb8c-5369-49c1-ba48-36443636f3aa';
-- UPDATE cjams.personroletype
-- SET activeflag=1, updatedon='2024-03-08 15:27:12.452', updatedby='1b22ed17-fee6-4b52-ad10-ece560c9d6d2'
-- WHERE personroletypeid='c2eb6432-2e15-4263-b2d4-ab3b61b63b72';


update cjams.personroletype 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37702'
	where personroletypeid in ('c2eb6432-2e15-4263-b2d4-ab3b61b63b72','a080cb8c-5369-49c1-ba48-36443636f3aa')
		and activeflag = 1;

select actorrelationshipid,activeflag,updatedon,updatedby  from actorrelationship where intakeserviceid = '953105a9-27fa-4fa4-a196-bc29176c625e';

-- UPDATE cjams.actorrelationship
-- SET activeflag=1, updatedon='2024-03-08 15:27:12.452', updatedby='1b22ed17-fee6-4b52-ad10-ece560c9d6d2'
-- WHERE actorrelationshipid='a931a8d9-10b0-49e0-919b-c37632b9341a';
-- UPDATE cjams.actorrelationship
-- SET activeflag=1, updatedon='2024-03-08 15:27:12.452', updatedby='1b22ed17-fee6-4b52-ad10-ece560c9d6d2'
-- WHERE actorrelationshipid='f836ea95-bb3d-4a2f-8607-6cfabc04c5c2';


update cjams.actorrelationship 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37702'
	where actorrelationshipid in ('f836ea95-bb3d-4a2f-8607-6cfabc04c5c2','a931a8d9-10b0-49e0-919b-c37632b9341a')
		and activeflag = 1;
		
select activeflag,updatedon,updatedby from cjams.personprogramarea
	where personid = '1ca09d9f-ab87-43cb-b5a2-aeeb34a66f4c'
		and objectid = '953105a9-27fa-4fa4-a196-bc29176c625e'
		and activeflag = 1;

-- UPDATE cjams.personprogramarea
-- SET activeflag=1, updatedon='2024-03-08 15:27:15.993', updatedby='1b22ed17-fee6-4b52-ad10-ece560c9d6d2'
-- WHERE personid = '1ca09d9f-ab87-43cb-b5a2-aeeb34a66f4c' and objectid = '953105a9-27fa-4fa4-a196-bc29176c625e';

update cjams.personprogramarea 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37702'
	where personid = '1ca09d9f-ab87-43cb-b5a2-aeeb34a66f4c'
		and objectid = '953105a9-27fa-4fa4-a196-bc29176c625e'
		and activeflag = 1;