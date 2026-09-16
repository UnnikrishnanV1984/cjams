-- CDM-24462 - Mother missing in CJAMS Case
/*
-- Issue Description: 
	Mother 'KEELEY	ALYSSA	MCDONALD' missing in CJAMS Case

-- Case ID: 221030017566
-- Client ID: 200938134	(KEELEY	ALYSSA	MCDONALD) - 46d6296e-0201-4863-843d-577c3b23ecc0

-- Category/ Module: Person (Investigation Management)
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To keep only one role as isprimary for Client ID: 200938134
-- Update intakeserviceid, isprimary, activeflag

-- PARENT
select personid, intakeserviceid, servicecaseid, isprimary,
	intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
from intakeservicerequestactor 
where intakeservicerequestactorid = '7bb3f408-9c14-4ef6-bbe4-5f35c56b188a'
	and activeflag = 1 ;

update intakeservicerequestactor
set isprimary = true,
	updatedon = now(), 
	updatedby = 'CDM-24462'
where intakeservicerequestactorid = '7bb3f408-9c14-4ef6-bbe4-5f35c56b188a'
	and activeflag = 1 ;	

-- ICC
select personid, intakeserviceid, servicecaseid, isprimary,
	intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
from intakeservicerequestactor 
where intakeservicerequestactorid = '5cb7b2b7-d80a-47bc-b8ee-3ca248711d16'
	and activeflag = 1;

update intakeservicerequestactor
set isprimary = false,
	updatedon = now(), 
	updatedby = 'CDM-24462'
where intakeservicerequestactorid = '5cb7b2b7-d80a-47bc-b8ee-3ca248711d16'
	and activeflag = 1 ;

