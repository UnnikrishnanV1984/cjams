/*
   	-- CDM-28587 - Remove incorrect person ID
	-- Issue Description: 
	   221020278563:plse remove these incorrect person ID; 200986202 the correct person IDs are 2273943
	   intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	   
	-- email: georgina.atueyi@maryland.gov
	
	Needs to do as below:

	Update all contacts and assessments that are associated with client ID # 200986202 to client ID # 2273943.
	Remove the client ID # 200986202 from CPS IR Case 221020278563 once point # 1 is done.

	client ID # 200986202
	personid:"b9d7ad8f-d565-485c-873a-8652c4bb737b"
	intakeservicerequestactorid: '1b07399b-0257-4616-aa1d-3f2481a3bca3'
	
	client ID # 2273943
	personid:"64b75c16-5010-4801-adb3-39cef4a16763"
	intakeservicerequestactorid: '5db72de5-b3ba-4ef4-9878-91c86195bc07'
	
	--------------------------------------------------------------------------------------------------------
   	-- CDM-28587 - Remove incorrect person ID
	-- Issue Description: 
	   221020278563:plse remove these incorrect person ID; 200986201 the correct person IDs are 2947375
	   intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	   
	-- email: georgina.atueyi@maryland.gov
	
	Needs to do as below:

	Update all contacts and assessments that are associated with client ID # 200986201 to client ID # 2947375.
	Remove the client ID # 200986201 from CPS IR Case 221020278563 once point # 1 is done.
	
	client ID # 200986201
	personid:"5d86f42a-2478-477b-beaf-1ca3c04e45cf"
	"intakeservicerequestactorid": "f56b7eda-23d8-4f52-80c7-6107d1c20246"
	
	client ID # 2947375
	personid:"703f7e4d-187d-48e7-92f7-b6c0864e33bb"
	intakeservicerequestactorid: 'b5962979-17cd-47db-b27f-125122c0a6ad'	
	--------------------------------------------------------------------------------------------------------
	select * from intakeservicerequest where servicerequestnumber = '221020278563'

	select * from actor where 
	personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b' and 
	intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d' and 
	activeflag = 1;

	select * from intakeservicerequestactor where 
	personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b' and 
	intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d' and 
	actorid = '823d719d-201c-4441-8585-8b0b14f457fe' and 
	activeflag = 1;
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
			and insr2.personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
	   );

update contactparticipant
set intakeservicerequestactorid = '5db72de5-b3ba-4ef4-9878-91c86195bc07', -- 2273943	CHILD
	updatedby = 'CDM-28587',
	updatedon = now()
where contactparticipantid
	in ( select cp.contactparticipantid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
					-- and cp.activeflag = 1
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
		where p.activeflag = 1
			and insr2.personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
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
									 where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
									   and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
									   -- and activeflag = 1
								    )
						 ) ;
						 
-- Update cjamspid in submissiondata
update assessment
set submissiondata = replace(submissiondata::text, '200986202', '2273943')::json,
	updatedby = 'CDM-28587',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
									   and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
									   -- and activeflag = 1
								    )
						 ) ;
				
			
-- Added on 08/23/2022				
-- Update intakeservicerequestactorid in submissiondata				
update assessment
set submissiondata = replace(submissiondata::text, '1b07399b-0257-4616-aa1d-3f2481a3bca3', '5db72de5-b3ba-4ef4-9878-91c86195bc07')::json,
	updatedby = 'CDM-28587',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
									   and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
									   -- and activeflag = 1
								    )
						 ) ;						 

-- Fail safe update
update assessment
set submissiondata = replace(submissiondata::text, '1b07399b-0257-4616-aa1d-3f2481a3bca3', '5db72de5-b3ba-4ef4-9878-91c86195bc07')::json,
	updatedby = 'CDM-28587',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
								    )
						 )
and submissiondata::text like '%1b07399b-0257-4616-aa1d-3f2481a3bca3%' ;


-- Update Assessemnt intakeservicerequestactorid
select assessmentid, intakeservicerequestactorid, activeflag, updatedby, updatedon
   from assessmentactor
where intakeservicerequestactorid 
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		 where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
			and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
				-- and activeflag = 1
	    ) ;	
		
update assessmentactor
set intakeservicerequestactorid = '5db72de5-b3ba-4ef4-9878-91c86195bc07', -- 2273943	CHILD
	updatedby = 'CDM-28587',
	updatedon = now()
where intakeservicerequestactorid 
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		 where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
			and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
				-- and activeflag = 1
	    ) ;	

-- Delete Program Assignment(s)
select *,programkey, objectid, objecttypekey, startdate, enddate, activeflag, updatedby, updatedon 
	from personprogramarea
where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
	and objectid = '809d1a26-d51d-4516-8dce-133244f4450d' 
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-28587',
	updatedon = now()
where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
	and personprogramid = 'ed1ec852-d36c-45a7-b84e-e25c4164366e' 
	and activeflag = 1 ;

-- Delete Actor
select actorid, actortype, activeflag, updatedby, updatedon
	from actor
where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
	and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-28587',
	updatedon = now()
where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
	and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	and activeflag = 1 ;

-- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
	and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-28587',
	updatedon = now()
where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
	and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
			and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
		)
	and activeflag = 1 ;
	
update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-28587',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
			and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select servicecaseid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
	and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-28587',
	updatedon = now()
where personid = 'b9d7ad8f-d565-485c-873a-8652c4bb737b'
	and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	and activeflag = 1 ;
	
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
			and insr2.personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
	   ) ;

update contactparticipant
set intakeservicerequestactorid = 'b5962979-17cd-47db-b27f-125122c0a6ad', -- 2947375	CHILD
	updatedby = 'CDM-28587',
	updatedon = now()
where contactparticipantid
	in ( select cp.contactparticipantid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
					-- and cp.activeflag = 1
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
		where p.activeflag = 1
			and insr2.personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
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
									 where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
									   and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
									   -- and activeflag = 1
								    )
						 ) ;
						 
-- Update cjamspid in submissiondata
update assessment
set submissiondata = replace(submissiondata::text, '200986201', '2947375')::json,
	updatedby = 'CDM-28587',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
									   and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
									   -- and activeflag = 1
								    )
						 ) ;
				
			
-- Added on 08/23/2022				
-- Update intakeservicerequestactorid in submissiondata				
update assessment
set submissiondata = replace(submissiondata::text, 'f56b7eda-23d8-4f52-80c7-6107d1c20246', 'b5962979-17cd-47db-b27f-125122c0a6ad')::json,
	updatedby = 'CDM-28587',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
									   and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
									   -- and activeflag = 1
								    )
						 ) ;						 

-- Fail safe update
update assessment
set submissiondata = replace(submissiondata::text, 'f56b7eda-23d8-4f52-80c7-6107d1c20246', 'b5962979-17cd-47db-b27f-125122c0a6ad')::json,
	updatedby = 'CDM-28587',
	updatedon = now()
where assessmentid in (	select assessmentid
								from assessmentactor
							where intakeservicerequestactorid 
								in ( select intakeservicerequestactorid
										from intakeservicerequestactor
									 where intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
								    )
						 )
and submissiondata::text like '%f56b7eda-23d8-4f52-80c7-6107d1c20246%' ;


-- Update Assessemnt intakeservicerequestactorid
select assessmentid, intakeservicerequestactorid, activeflag, updatedby, updatedon
   from assessmentactor
where intakeservicerequestactorid 
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		 where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
			and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
				-- and activeflag = 1
	    ) ;	
		
update assessmentactor
set intakeservicerequestactorid = 'b5962979-17cd-47db-b27f-125122c0a6ad', -- 2947375	CHILD
	updatedby = 'CDM-28587',
	updatedon = now()
where intakeservicerequestactorid 
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		 where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
			and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
				-- and activeflag = 1
	    ) ;	

-- Delete Program Assignment(s)
select *,programkey, objectid, objecttypekey, startdate, enddate, activeflag, updatedby, updatedon 
	from personprogramarea
where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
	and objectid = '809d1a26-d51d-4516-8dce-133244f4450d' 
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-28587',
	updatedon = now()
where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
	and personprogramid = '538d5c6c-3b8c-49e0-ac80-e46ea9eea22a' 
	and activeflag = 1 ;

-- Delete Actor
select actorid, actortype, activeflag, updatedby, updatedon
	from actor
where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
	and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-28587',
	updatedon = now()
where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
	and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	and activeflag = 1 ;

-- Delete Person Role(s)
select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
	and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-28587',
	updatedon = now()
where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
	and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
			and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
		)
	and activeflag = 1 ;
	
update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-28587',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
			and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select servicecaseid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
	and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-28587',
	updatedon = now()
where personid = '5d86f42a-2478-477b-beaf-1ca3c04e45cf'
	and intakeserviceid = '809d1a26-d51d-4516-8dce-133244f4450d'
	and activeflag = 1 ;