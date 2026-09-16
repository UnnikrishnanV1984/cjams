-- CDM-31998 - remove person ID from case
/*
-- Issue Description: 
	User request to delete the duplicate client # 200960725 from CPS-IR Case 221020257343
	after transferring the contacts and assessments to active client # 4483657.
   

-- CPS-IR Case ID: 221020257343 - 3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b
-- Keep
-- Client ID: 4483657 (ERIC GREEN) - e055e4d1-8597-4f2e-b75c-add9dd31eebe
-- actorid: b42ae014-993d-492a-bf2b-b45017024e93
-- intakeservicerequestactorid: af8e5f6b-f437-4579-8fa0-df2430551212 - AV

-- Delete 
-- Client ID: 200960725	(Eric DUPLICATE	Green Jr) - 93f68f81-b4bf-4168-b462-88d7c5eef83c
-- actorid: 499bd4ab-a3d8-48c8-be57-399f1f6435f3
-- intakeservicerequestactorid: 818d4e2a-dba4-4625-9c11-0ecd6dc250c5 - OTHCHNH
-- intakeservicerequestactorid: 8644acfc-85c8-44e6-b313-eae30b7cab95 - CHILD
   
-- Category/ Module: Case Data (Case Management)
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to delete the duplicate client # 200960725 from CPS-IR Case 221020257343.
--		         And to transfer the contacts and assessments to active client # 4483657
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Contact notes
select contactparticipantid, intakeservicerequestactorid, activeflag, updatedby, updatedon
	from contactparticipant
where contactparticipantid
	in ( select cp.contactparticipantid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
					-- and cp.activeflag = 1
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
		where p.activeflag = 1
			and insr2.personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
			and insr2.intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
	   ) ;

update contactparticipant
set intakeservicerequestactorid = 'af8e5f6b-f437-4579-8fa0-df2430551212', -- 4483657	AV
	updatedby = 'CDM-31998',
	updatedon = now()
where contactparticipantid
	in ( select cp.contactparticipantid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
					-- and cp.activeflag = 1
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
		where p.activeflag = 1
			and insr2.personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
			and insr2.intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
	   ) ;


-- Assessments - CANS-F Assessment, MFIRA Assessments, Approved SafeC assessments
-- Update Assessemnt submissiondata
select assessmentid, activeflag, updatedby, updatedon, submissiondata
	from assessment
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
									   and intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
									   -- and activeflag = 1
								    )
						 ) ;
						 
-- Update cjamspid in submissiondata
update assessment
set submissiondata = replace(submissiondata::text, '200960725', '4483657')::json,
	updatedby = 'CDM-31998',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
									   and intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
									   -- and activeflag = 1
								    )
						 ) ;
				
			
-- Update intakeservicerequestactorid in submissiondata				
-- 818d4e2a-dba4-4625-9c11-0ecd6dc250c5	OTHCHNH
update assessment
set submissiondata = replace(submissiondata::text, '818d4e2a-dba4-4625-9c11-0ecd6dc250c5', 'af8e5f6b-f437-4579-8fa0-df2430551212')::json,
	updatedby = 'CDM-31998',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
									   and intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
									   -- and activeflag = 1
								    )
						 ) ;						 

-- Fail Safe update
-- 8644acfc-85c8-44e6-b313-eae30b7cab95	CHILD
update assessment
set submissiondata = replace(submissiondata::text, '8644acfc-85c8-44e6-b313-eae30b7cab95', 'af8e5f6b-f437-4579-8fa0-df2430551212')::json,
	updatedby = 'CDM-31998',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
								    )
						 )
-- and submissiondata::text like '%1f55ab81-cb0f-4669-b8f9-c02fa6dd15f6%' 
;


-- Update Assessemnt intakeservicerequestactorid
select assessmentid, intakeservicerequestactorid, activeflag, updatedby, updatedon
   from assessmentactor
where intakeservicerequestactorid 
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		 where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
			and intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
				-- and activeflag = 1
	    ) ;	
		
update assessmentactor
set intakeservicerequestactorid = 'af8e5f6b-f437-4579-8fa0-df2430551212', -- 4483657	AV
	updatedby = 'CDM-31998',
	updatedon = now()
where intakeservicerequestactorid 
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		 where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
			and intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
				-- and activeflag = 1
	    ) ;	

-- Delete Program Assignment(s)
select programkey, subprogramkey, objectid, objecttypekey, startdate, enddate, activeflag, updatedby, updatedon 
	from personprogramarea
where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
	and objectid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b' 
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-31998',
	updatedon = now()
where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
	and objectid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b' 
	and activeflag = 1 ;
	
-- Delete Actor
select actorid, actortype, activeflag, updatedby, updatedon
	from actor
where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
	and intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-31998',
	updatedon = now()
where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
	and intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
	and activeflag = 1 ;

-- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
	and intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-31998',
	updatedon = now()
where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
	and intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
			and intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
		)
	and activeflag = 1 ;
	
update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-31998',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
			and intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select intakeserviceid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
	and intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-31998',
	updatedon = now()
where personid = '93f68f81-b4bf-4168-b462-88d7c5eef83c'
	and intakeserviceid = '3e6ab10e-02bb-4f2f-aeae-18eaa1a20b2b'
	and activeflag = 1 ;

