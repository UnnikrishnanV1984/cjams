-- CDM-27341 - Same CJAMSPID
/*
-- Issue Description: 
	There are two individuals with the same CJAMSPID. 
	This is causing duplicate service authorizations to populate. 
	The individuals are Dakota Davis and Robert Buxenstein IV. 
	Robert Buxenstein has no association to this case. 

-- Category/ Module: Case Management
-- Root cause: Data Migration Issue (ClientFlag is 2 for this record)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Case ID: 3168674
-- CW cjamspid: 31990 (DAKOTA DANIEL DAVIS) - ce89f6c6-cb49-498d-b258-b4b73b71c62a
-- CIS CLient ID: 401032453 (MDT-128868739)
-- clientflag: 1 
-- MD CHESSIE - 31990 (DAKOTA DANIEL DAVIS)

-- Other Duplicate: 31990 (ROBERT BUXENSTEIN) - b5bd69b3-3610-4713-8238-9637bad25ece
-- CIS Client ID: Not Registered with MDM 
-- clientflag: 2 
-- NOT Invloved in any case 

-- Before 
select cjamspid, firstname, middlename, lastname, dob, ssnno, clientflag, cisclientid, 
	personid, activeflag, updatedby, updatedon
from person
where personid = 'b5bd69b3-3610-4713-8238-9637bad25ece'
	and activeflag = 1;

-- Generate new cjamspid
update person
set cjamspid = nextval('sequence_for_alpha_numerics'::regclass),
	ssnno = NULL, --219301679
	updatedby = 'CDM-27341', 
	updatedon = now()
where personid = 'b5bd69b3-3610-4713-8238-9637bad25ece'
	and activeflag = 1;
	
-- After 
select cjamspid, firstname, middlename, lastname, dob, ssnno, clientflag, cisclientid, 
	personid, activeflag, updatedby, updatedon
from person
where personid = 'b5bd69b3-3610-4713-8238-9637bad25ece'
	and activeflag = 1;
