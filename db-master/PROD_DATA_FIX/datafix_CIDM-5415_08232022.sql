-- CIDM-5415 - Need to remove other persons based on the screenshot
/*
-- Issue Description: 
	For testing purpose, we need 2 persons in other to validate WSO2 migration in Prod. Now we need to delete those persons
		Kristie Lynn Alexandria
		Misty B Sharpless
   
-- Case ID: 3283151 - 20fdf348-c258-4869-8f28-0a1182e69e0e
-- Clients 
-- 1584159 (KRISTIE	LYNN ALEXANDER) - c7e23ee7-7c45-4604-985d-89f5c4cf06b1
-- 4174824 (MISTY B	SHARPLESS) - e4adddf9-d6b1-4fea-ac70-51b4b6164964
   
-- Category/ Module: Case Data (Case Management)
-- Root cause: WSO2 migration validate
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Program Assignment(s)
select programkey, objectid, objecttypekey, activeflag, updatedby, updatedon 
	from personprogramarea
where personid in (	'c7e23ee7-7c45-4604-985d-89f5c4cf06b1',
					'e4adddf9-d6b1-4fea-ac70-51b4b6164964'
				  )
	and objectid = '20fdf348-c258-4869-8f28-0a1182e69e0e' 
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CIDM-5415',
	updatedon = now()
where personid in (	'c7e23ee7-7c45-4604-985d-89f5c4cf06b1',
					'e4adddf9-d6b1-4fea-ac70-51b4b6164964'
				  )
	and objectid = '20fdf348-c258-4869-8f28-0a1182e69e0e' 
	and activeflag = 1 ;

-- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid in (	'c7e23ee7-7c45-4604-985d-89f5c4cf06b1',
					'e4adddf9-d6b1-4fea-ac70-51b4b6164964'
				  )
	and servicecaseid  = '20fdf348-c258-4869-8f28-0a1182e69e0e'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CIDM-5415',
	updatedon = now()
where personid in (	'c7e23ee7-7c45-4604-985d-89f5c4cf06b1',
					'e4adddf9-d6b1-4fea-ac70-51b4b6164964'
				  )
	and servicecaseid  = '20fdf348-c258-4869-8f28-0a1182e69e0e'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid 
				in ( 'c7e23ee7-7c45-4604-985d-89f5c4cf06b1',
					 'e4adddf9-d6b1-4fea-ac70-51b4b6164964'
				   )
			and servicecaseid  = '20fdf348-c258-4869-8f28-0a1182e69e0e'
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CIDM-5415',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid 
				in ( 'c7e23ee7-7c45-4604-985d-89f5c4cf06b1',
					 'e4adddf9-d6b1-4fea-ac70-51b4b6164964'
				   )
			and servicecaseid = '20fdf348-c258-4869-8f28-0a1182e69e0e'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select servicecaseid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid in ( 'c7e23ee7-7c45-4604-985d-89f5c4cf06b1',
					 'e4adddf9-d6b1-4fea-ac70-51b4b6164964'
				   )
	and servicecaseid = '20fdf348-c258-4869-8f28-0a1182e69e0e'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CIDM-5415',
	updatedon = now()
where personid in ( 'c7e23ee7-7c45-4604-985d-89f5c4cf06b1',
					 'e4adddf9-d6b1-4fea-ac70-51b4b6164964'
				   )
	and servicecaseid = '20fdf348-c258-4869-8f28-0a1182e69e0e'
	and activeflag = 1 ;

-- Delete Actor
select actorid, actortype, activeflag, updatedby, updatedon
	from actor
where personid in ( 'c7e23ee7-7c45-4604-985d-89f5c4cf06b1',
					 'e4adddf9-d6b1-4fea-ac70-51b4b6164964'
				   )
and servicecaseid  = '20fdf348-c258-4869-8f28-0a1182e69e0e'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CIDM-5415',
	updatedon = now()
where personid in ( 'c7e23ee7-7c45-4604-985d-89f5c4cf06b1',
					 'e4adddf9-d6b1-4fea-ac70-51b4b6164964'
				   )
and servicecaseid  = '20fdf348-c258-4869-8f28-0a1182e69e0e'
	and activeflag = 1 ;
