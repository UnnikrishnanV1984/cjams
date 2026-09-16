-- CDM-36633 - Delete Person from Case
/*
-- Issue Description: 
   User added person by mistake and need to  delete the record
      
-- Case ID: 241021815463 - 6422f86c-8678-4a5d-b44a-d5e53f15fb78
-- Client ID (To be Deleted) -- 202700553 - 928fe50b-63fc-4694-a739-41840be65fb6

-- Fix Provided: Datafix has been provided to delete the person. 
--				 Deleted person is not present in Contacts & Assessments (SAFE-C & MIFRA). No action needed here.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- intakeservicerequestactorid - 15ca2faa-29a2-484d-b611-c6a4e62320d9
select * from intakeservicerequestactor 
	where intakeserviceid = '6422f86c-8678-4a5d-b44a-d5e53f15fb78' 
		and personid = '928fe50b-63fc-4694-a739-41840be65fb6' 
		and activeflag = 1;


UPDATE intakeservicerequestactor
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36633'
	WHERE intakeservicerequestactorid = '15ca2faa-29a2-484d-b611-c6a4e62320d9';
	
--  No corrections needed in contactparticipant table
select p.cjamspid, cp.contactparticipantid, cp.intakeservicerequestactorid 
	from progressnote pn 
		join contactparticipant cp on cp.progressnoteid = pn.progressnoteid and cp.activeflag = 1
		join intakeservicerequestactor isra on isra.intakeservicerequestactorid = cp.intakeservicerequestactorid 
		join person p on p.personid = isra.personid and p.activeflag = 1
	where pn.EntityTypeId = '6422f86c-8678-4a5d-b44a-d5e53f15fb78'
		and p.cjamspid = 202700553;	

--  No corrections needed in focusperson of progressnote table		
select *
	from progressnote pn 
	where pn.EntityTypeId = '6422f86c-8678-4a5d-b44a-d5e53f15fb78'
		and pn.focusperson::character varying like '%15ca2faa-29a2-484d-b611-c6a4e62320d9%'	;

		
