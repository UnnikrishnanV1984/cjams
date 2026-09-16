-- CIDM-4301 - CSES outbound job failed with data issue
/*
-- Issue Description: 
   Wed Feb 23 18:28:21 EST 2022 SP_CSES_INTERFACE_GENERATE_OUTBOUND fails
	FAILED BEGIN TO GENERATE INTERFACE DATA FOR TRANSACTION_TYPE_CD:70 AND CLIENT_ID:235989
	FAILED TO GENERATE INTERFACE DATA FOR RECORD TYPE(s):20-
	SELECT relationshiptypekey FAILED FOR actorrelationship
	more than one row returned by a subquery used as an expression; AND CLIENT_ID:235989   
	
	1) Client ID: 235989 (Aim'ee Carol Polk) - 94909b13-5f7c-4a57-b9c4-ab3982f6bd85 
	   Correct Person migrated from MD CHESSIE (Verified this in the last MD CHESSIE DB backup)

	2) Client ID: 235989 (FRANKLIN THEODORE	WRIGHT) - c242e33d-1e02-49ef-8fbd-86c5dc53e191
	   This person is not having MDM ID or CIS Client ID and also not involved in any CJAMS case.
	   How this person got the same Cjams PID is unknown at this time and we have 295 more Cjams PIDs 
	   with multiple Person IDs. 

-- Category/ Module: CJAMS - CSES Interface (Putbound Batch)
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD 
*/

-- Datafix to assign new cjamspid (next value) and soft delete the perosn record 

select cjamspid, firstname, middlename, lastname, cisclientid, activeflag, updatedby, updatedon  
	from person 
where cjamspid = 235989 ;

select cjamspid, firstname, middlename, lastname, cisclientid, activeflag, updatedby, updatedon 
	from person 
where personid = 'c242e33d-1e02-49ef-8fbd-86c5dc53e191'
and activeflag = 1 ;

update person
set cjamspid = nextval('sequence_for_alpha_numerics'::regclass),
	activeflag = 0,
	updatedby = 'CIDM-4301',
	updatedon = now()
where personid = 'c242e33d-1e02-49ef-8fbd-86c5dc53e191'
and activeflag = 1 ;

select cjamspid, firstname, middlename, lastname, cisclientid, activeflag, updatedby, updatedon  
	from person 
where cjamspid = 235989 ;
