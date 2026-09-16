/*
 * CDM-38040 - Remove Person From Persons Tab
 * Customer Email ID:chania.rolling1@maryland.gov
 * Focus Area:Persons
 * Identified As:User Error
 * Description - 241021929270:Please remove these two individuals from the persons tab. These people were added in by mistake. 
 * These individuals do not exist. Taylor Harris (CJAMS PID: 202832684)Lamar Harris (CJAMS PID: 202832682) 
 */

-- Delete Program Assignment(s)
select *,programkey, objectid, objecttypekey, startdate, enddate, activeflag, updatedby, updatedon 
	from personprogramarea
where personid in ('23569d99-198c-4f48-a249-c4f8a67d6ab8','c6cd0666-8a76-47d0-b9b5-13f950869f52')
	and objectid = 'aa3e6088-a859-498d-b43d-eb1908b84b06' 
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-38040',
	updatedon = now()
where personid in ('23569d99-198c-4f48-a249-c4f8a67d6ab8','c6cd0666-8a76-47d0-b9b5-13f950869f52')
	and personprogramid = 'ed1ec852-d36c-45a7-b84e-e25c4164366e' 
	and activeflag = 1 ;

-- Delete Actor
select actorid, actortype, activeflag, updatedby, updatedon
	from actor
where personid in ('23569d99-198c-4f48-a249-c4f8a67d6ab8','c6cd0666-8a76-47d0-b9b5-13f950869f52')
	and intakeserviceid = 'aa3e6088-a859-498d-b43d-eb1908b84b06'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-38040',
	updatedon = now()
where personid in ('23569d99-198c-4f48-a249-c4f8a67d6ab8','c6cd0666-8a76-47d0-b9b5-13f950869f52')
	and intakeserviceid = 'aa3e6088-a859-498d-b43d-eb1908b84b06'
	and activeflag = 1 ;

-- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid in ('23569d99-198c-4f48-a249-c4f8a67d6ab8','c6cd0666-8a76-47d0-b9b5-13f950869f52')
	and intakeserviceid = 'aa3e6088-a859-498d-b43d-eb1908b84b06'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-38040',
	updatedon = now()
where personid in ('23569d99-198c-4f48-a249-c4f8a67d6ab8','c6cd0666-8a76-47d0-b9b5-13f950869f52')
	and intakeserviceid = 'aa3e6088-a859-498d-b43d-eb1908b84b06'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid in ('23569d99-198c-4f48-a249-c4f8a67d6ab8','c6cd0666-8a76-47d0-b9b5-13f950869f52')
			and intakeserviceid = 'aa3e6088-a859-498d-b43d-eb1908b84b06'
		)
	and activeflag = 1 ;
	
update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-38040',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid in ('23569d99-198c-4f48-a249-c4f8a67d6ab8','c6cd0666-8a76-47d0-b9b5-13f950869f52')
			and intakeserviceid = 'aa3e6088-a859-498d-b43d-eb1908b84b06'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select intakeserviceid, servicecaseid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid in ('23569d99-198c-4f48-a249-c4f8a67d6ab8','c6cd0666-8a76-47d0-b9b5-13f950869f52')
	and intakeserviceid = 'aa3e6088-a859-498d-b43d-eb1908b84b06'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-38040',
	updatedon = now()
where personid in ('23569d99-198c-4f48-a249-c4f8a67d6ab8','c6cd0666-8a76-47d0-b9b5-13f950869f52')
	and intakeserviceid = 'aa3e6088-a859-498d-b43d-eb1908b84b06'
	and activeflag = 1 ;

-- Delete personroletype
select *
from personroletype p
where personroleid
in
(select personroleid
from personrole
where personid in ('23569d99-198c-4f48-a249-c4f8a67d6ab8','c6cd0666-8a76-47d0-b9b5-13f950869f52')
and intakeserviceid = 'aa3e6088-a859-498d-b43d-eb1908b84b06'
and activeflag = 1
)
and activeflag = 1;	

UPDATE cjams.personroletype
SET activeflag=0, updatedby = 'CDM-38040', updatedon = now()
WHERE personroletypeid in ('223ca226-2fe1-4b83-9997-5396a9e73ab2'::uuid, '1c6f2d7f-461c-47d0-a992-dc28f56c37a6'::uuid);
