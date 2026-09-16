-- CDM-28087 - Need to remove other persons based on the screenshot
/*
-- Issue Description: 

231020295779:Please delete the below client ID etc. It was duplicated when correcting information under the QA Candice Noble
Program Area:N/ACJAMS PID#:201010087CIS ID#:503068618D.O.B:08/10/1986AGE:36 YrsGENDER:FADDRESS:N/A
Role(s):Legal Guardian , Initial Contact Caregiver , Parent , Alleged Maltreator

CPS-AR : 231020295779
"personid":"e7dabf08-f616-4adc-9ac3-0c9225bfaaf2"
"intakeserviceid":"8a65d49e-1a78-4842-bde2-a5300137f675"
-- Candice Noble

*/

-- Delete Program Assignment(s)
select programkey, objectid, objecttypekey, activeflag, updatedby, updatedon 
	from personprogramarea
where personid in (	'e7dabf08-f616-4adc-9ac3-0c9225bfaaf2'
				  )
	and objectid = '8a65d49e-1a78-4842-bde2-a5300137f675' 
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-28087',
	updatedon = now()
where personid in (	'e7dabf08-f616-4adc-9ac3-0c9225bfaaf2'
				  )
	and objectid = '8a65d49e-1a78-4842-bde2-a5300137f675' 
	and activeflag = 1 ;

-- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid in (	'e7dabf08-f616-4adc-9ac3-0c9225bfaaf2'
				  )
	and intakeserviceid  = '8a65d49e-1a78-4842-bde2-a5300137f675' 
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-28087',
	updatedon = now()
where personid in (	'e7dabf08-f616-4adc-9ac3-0c9225bfaaf2'
				  )
	and intakeserviceid  = '8a65d49e-1a78-4842-bde2-a5300137f675' 
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid 
				in ( 'e7dabf08-f616-4adc-9ac3-0c9225bfaaf2'
				   )
			and intakeserviceid  = '8a65d49e-1a78-4842-bde2-a5300137f675' 
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-28087',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid 
				in ( 'e7dabf08-f616-4adc-9ac3-0c9225bfaaf2'
				   )
			and intakeserviceid = '8a65d49e-1a78-4842-bde2-a5300137f675' 
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select intakeserviceid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid in ( 'e7dabf08-f616-4adc-9ac3-0c9225bfaaf2'
				   )
	and intakeserviceid = '8a65d49e-1a78-4842-bde2-a5300137f675' 
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-28087',
	updatedon = now()
where personid in ( 'e7dabf08-f616-4adc-9ac3-0c9225bfaaf2'
				   )
	and intakeserviceid = '8a65d49e-1a78-4842-bde2-a5300137f675' 
	and activeflag = 1 ;

-- Delete Actor
select actorid, actortype, activeflag, updatedby, updatedon
	from actor
where personid in ( 'e7dabf08-f616-4adc-9ac3-0c9225bfaaf2'
				   )
and intakeserviceid  = '8a65d49e-1a78-4842-bde2-a5300137f675' 
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-28087',
	updatedon = now()
where personid in ( 'e7dabf08-f616-4adc-9ac3-0c9225bfaaf2'
				   )
and intakeserviceid  = '8a65d49e-1a78-4842-bde2-a5300137f675' 
	and activeflag = 1 ;