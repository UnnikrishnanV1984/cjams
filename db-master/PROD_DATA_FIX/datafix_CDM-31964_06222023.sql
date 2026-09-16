-- CDM-31964 - Client entered twice
/*
-- Issue Description: 
	User request to delete the duplicate client # 201162684 from CPS-IR Case 231020448747
	after transferring the contacts and assessments to active client # 201162683.
   
-- CPS-IR: 231020448747 - b068745a-d90f-4980-b471-4dc0f5e87b5a

-- Keep
-- Client ID: 201162683	(Gabriel J Vaeth) - 0e991de7-31fd-41b6-9ba1-a4c03030f670
-- Maltreatment is recorded for this client  
-- actorid: 49ccdaac-6190-4beb-a4ff-4f2b9b0d3618
-- intakeservicerequestactorid: e35bec03-f03b-4c88-a2ea-2f9d87bff130 - CHILD

-- Delete 
-- Client ID: 201162684	(Gabriel J Vaeth) -	aa49557b-bd81-40fc-a307-4172dfeb15ba
-- Maltreatment is not applicable for this client
-- actorid: 153664c9-bd09-4bce-86e3-f49be8ce1c1d
-- intakeservicerequestactorid: 1f55ab81-cb0f-4669-b8f9-c02fa6dd15f6 - CHILD
-- intakeservicerequestactorid: fb3e9e10-941b-4237-b3b9-af4d9c7dc1d9 - AV
   
-- Category/ Module: Case Data (Case Management)
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to delete the duplicate client # 201162684 from CPS-IR Case 231020448747.
--		         And to transfer the contacts and assessments to active client # 201162683
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
			and insr2.personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
			and insr2.intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
	   ) ;

update contactparticipant
set intakeservicerequestactorid = 'e35bec03-f03b-4c88-a2ea-2f9d87bff130', -- 201162683	CHILD
	updatedby = 'CDM-31964',
	updatedon = now()
where contactparticipantid
	in ( select cp.contactparticipantid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
					-- and cp.activeflag = 1
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
		where p.activeflag = 1
			and insr2.personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
			and insr2.intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
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
									 where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
									   and intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
									   -- and activeflag = 1
								    )
						 ) ;
						 
-- Update cjamspid in submissiondata
update assessment
set submissiondata = replace(submissiondata::text, '201162684', '201162683')::json,
	updatedby = 'CDM-31964',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
									   and intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
									   -- and activeflag = 1
								    )
						 ) ;
				
			
-- Added on 08/23/2022				
-- Update intakeservicerequestactorid in submissiondata				
update assessment
set submissiondata = replace(submissiondata::text, '1f55ab81-cb0f-4669-b8f9-c02fa6dd15f6', 'e35bec03-f03b-4c88-a2ea-2f9d87bff130')::json,
	updatedby = 'CDM-31964',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
									   and intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
									   -- and activeflag = 1
								    )
						 ) ;						 

-- Fail Safe update
update assessment
set submissiondata = replace(submissiondata::text, '1f55ab81-cb0f-4669-b8f9-c02fa6dd15f6', 'e35bec03-f03b-4c88-a2ea-2f9d87bff130')::json,
	updatedby = 'CDM-31964',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
								    )
						 )
and submissiondata::text like '%1f55ab81-cb0f-4669-b8f9-c02fa6dd15f6%' ;


-- Update Assessemnt intakeservicerequestactorid
select assessmentid, intakeservicerequestactorid, activeflag, updatedby, updatedon
   from assessmentactor
where intakeservicerequestactorid 
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		 where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
			and intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
				-- and activeflag = 1
	    ) ;	
		
update assessmentactor
set intakeservicerequestactorid = 'e35bec03-f03b-4c88-a2ea-2f9d87bff130', -- 201162683	CHILD
	updatedby = 'CDM-31964',
	updatedon = now()
where intakeservicerequestactorid 
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		 where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
			and intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
				-- and activeflag = 1
	    ) ;	

-- Delete Program Assignment(s)
select programkey, objectid, objecttypekey, startdate, enddate, activeflag, updatedby, updatedon 
	from personprogramarea
where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
	and objectid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a' 
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-31964',
	updatedon = now()
where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
	and objectid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a' 
	and activeflag = 1 ;
	
-- Delete Actor
select actorid, actortype, activeflag, updatedby, updatedon
	from actor
where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
	and intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-31964',
	updatedon = now()
where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
	and intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
	and activeflag = 1 ;

-- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
	and intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-31964',
	updatedon = now()
where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
	and intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
			and intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
		)
	and activeflag = 1 ;
	
update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-31964',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
			and intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select intakeserviceid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
	and intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-31964',
	updatedon = now()
where personid = 'aa49557b-bd81-40fc-a307-4172dfeb15ba'
	and intakeserviceid = 'b068745a-d90f-4980-b471-4dc0f5e87b5a'
	and activeflag = 1 ;

