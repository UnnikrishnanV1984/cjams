-- CDM-24272 - Duplicate client
/*
-- Issue Description: 
	Duplicate client showing in CPS-IR Case 221020238853

-- CPS-IR ID: 221020238853 - 894fcbe1-6c6c-4f95-b525-2cadc4e16564
-- Client ID: 200938134	(KEELEY	ALYSSA	MCDONALD) - 46d6296e-0201-4863-843d-577c3b23ecc0

-- Category/ Module: Person (Investigation Management)
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To keep only one role as isprimary for Client ID: 200938134
-- Update intakeserviceid, isprimary, activeflag
select personid, intakeserviceid, servicecaseid, isprimary,
	intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
from intakeservicerequestactor 
where intakeservicerequestactorid = '7bb3f408-9c14-4ef6-bbe4-5f35c56b188a'
	and activeflag = 1 
	and isprimary = true ;

update intakeservicerequestactor
set isprimary = false,
	updatedon = now(), 
	updatedby = 'CDM-24272'
where intakeservicerequestactorid = '7bb3f408-9c14-4ef6-bbe4-5f35c56b188a'
	and activeflag = 1 
	and isprimary = true ;	
