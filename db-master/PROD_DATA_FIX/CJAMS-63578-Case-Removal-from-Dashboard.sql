/*
-- Issue Description: 
    I251013328150:I am unable to remove this case from my Dashboard 
    -- Category/ Module: Persons
-- Root cause: User Request/Error, user created intake in error and requested to remove the intake I251013328150 from the dashboard.
-- Resolution: Removing intake records from intakedastaging, intakedastatus, actor, intakeserviceactor. personrole and personroletype tables.
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakedastaging 
set activeflag = 0, 
	updatedby = 'CJAMS-63578', 
	updatedon = now()
where intakenumber = 'I251013328150'
	and activeflag =1;

update intakedastatus 
set 
	activeflag = 0,
	updatedby = 'CJAMS-63578',
	updatedon = now()
where intakenumber = 'I251013328150'
	and activeflag =1;

-- Update actor
UPDATE actor
SET activeflag = 0,
    updatedby = 'CJAMS-63578',
    updatedon = now()
WHERE intakenumber = 'I251013328150' AND activeflag = 1;

-- Update intakeservicerequestactor
UPDATE intakeservicerequestactor
SET activeflag = 0,
    updatedby = 'CJAMS-63578',
    updatedon = now()
WHERE intakenumber = 'I251013328150' AND activeflag = 1;

-- Update personrole
--select * from personrole where intakenumber = 'I251013328150'

UPDATE personrole
SET activeflag = 0,
    updatedby = 'CJAMS-63578',
    updatedon = now()
WHERE intakenumber = 'I251013328150' AND activeflag = 1;

-- Update personroletype
UPDATE personroletype
SET activeflag = 0,
    updatedby = 'CJAMS-63578',
    updatedon = now()
where personroleid = '7ae4715b-7804-49f4-957a-1b3d49937948'
	AND activeflag = 1;