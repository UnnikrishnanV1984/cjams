-- CDM-23053 - There are 2 children with similar names listed in persons.
/*
-- Issue Description: 
	User request to delete the duplicate client from Service case.
	Move Contact notes, CANS-F Assessment, MFIRA Assessments & Approved SafeC assessments data of 200022780 to 4238345
   
-- Case ID: 2020019901878 - f867dde6-20fd-4d23-a7c6-93800a995ccb
-- Client ID: 4238345 (Makayla Nyima MOSLEY) - 6bfdb77d-5320-477c-8b14-85d81eeee331
-- Client ID: 200022780 (MAKAYLA NYIMA MOSLEY) - f7742cbd-283b-49d6-beae-bfb0779a11c1
   
-- Category/ Module: Case Data (Case Management)
-- Root cause: User Error
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
			and insr2.personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
	   ) ;

update contactparticipant
set intakeservicerequestactorid = 'fba634bc-3a99-4388-9956-8d3ce0c3c79d', -- 4238345	CHILD
	updatedby = 'CDM-23053',
	updatedon = now()
where contactparticipantid
	in ( select cp.contactparticipantid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
					-- and cp.activeflag = 1
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
		where p.activeflag = 1
			and insr2.personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
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
									 where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
									   and servicecaseid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb'
									   -- and activeflag = 1
								    )
						 ) ;
						 
-- Update cjamspid in submissiondata
update assessment
set submissiondata = replace(submissiondata::text, '200022780', '4238345')::json,
	updatedby = 'CDM-23053',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
									   and servicecaseid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb'
									   -- and activeflag = 1
								    )
						 ) ;
				
-- Added on 08/23/2022				
-- Update intakeservicerequestactorid in submissiondata				
update assessment
set submissiondata = replace(submissiondata::text, '3a49b901-c71a-418d-88e2-a1e656207cda', 'fba634bc-3a99-4388-9956-8d3ce0c3c79d')::json,
	updatedby = 'CDM-23053',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
									   and servicecaseid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb'
									   -- and activeflag = 1
								    )
						 ) ;						 

-- Update Assessemnt intakeservicerequestactorid
select assessmentid, intakeservicerequestactorid, activeflag, updatedby, updatedon
   from assessmentactor
where intakeservicerequestactorid 
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		 where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
			and servicecaseid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb'
				-- and activeflag = 1
	    ) ;	
		
update assessmentactor
set intakeservicerequestactorid = 'fba634bc-3a99-4388-9956-8d3ce0c3c79d', -- 4238345	CHILD
	updatedby = 'CDM-23053',
	updatedon = now()
where intakeservicerequestactorid 
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		 where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
			and servicecaseid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb'
				-- and activeflag = 1
	    ) ;	

-- Delete Program Assignment(s)
select programkey, objectid, objecttypekey, activeflag, updatedby, updatedon 
	from personprogramarea
where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
	and objectid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb' 
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-23053',
	updatedon = now()
where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
	and objectid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb' 
	and activeflag = 1 ;
	
-- Delete Actor
select actorid, actortype, activeflag, updatedby, updatedon
	from actor
where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
	and servicecaseid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-23053',
	updatedon = now()
where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
	and servicecaseid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb'
	and activeflag = 1 ;

-- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
	and servicecaseid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-23053',
	updatedon = now()
where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
	and servicecaseid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
			and servicecaseid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb'
		)
	and activeflag = 1 ;
	
update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-23053',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
			and servicecaseid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select servicecaseid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
	and servicecaseid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-23053',
	updatedon = now()
where personid = 'f7742cbd-283b-49d6-beae-bfb0779a11c1'
	and servicecaseid = 'f867dde6-20fd-4d23-a7c6-93800a995ccb'
	and activeflag = 1 ;
