-- CDM-38442 - Erroneous Intake Entry
/*
-- Issue Description: 
	I241012127412:Erroneously entered case - remove intake
-- Category/ Module: Persons
-- Root cause: Decision/ Application
-- Resolution: Removing intake records from intakedastaging, intakedastatus, actor, intakeserviceactor. personrole and personroletype tables.
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



-- Update intakedastaging
UPDATE intakedastaging 
SET activeflag = 0, 
    updatedby = 'CDM-38442', 
    updatedon = now()
WHERE intakenumber = 'I241012127412' AND activeflag = 1;

-- Update intakedastatus
UPDATE intakedastatus
SET activeflag = 0,
    updatedby = 'CDM-38442',
    updatedon = now()
WHERE intakenumber = 'I241012127412' AND activeflag = 1;

-- Update actor
UPDATE actor
SET activeflag = 0,
    updatedby = 'CDM-38442',
    updatedon = now()
WHERE intakenumber = 'I241012127412' AND activeflag = 1;

-- Update intakeservicerequestactor
UPDATE intakeservicerequestactor
SET activeflag = 0,
    updatedby = 'CDM-38442',
    updatedon = now()
WHERE intakenumber = 'I241012127412' AND activeflag = 1;

-- Update personrole
UPDATE personrole
SET activeflag = 0,
    updatedby = 'CDM-38442',
    updatedon = now()
WHERE intakenumber = 'I241012127412' AND activeflag = 1;

-- Update personroletype
UPDATE personroletype
SET activeflag = 0,
    updatedby = 'CDM-38442',
    updatedon = now()
WHERE personroleid = 'bb1263da-94f8-4d3b-980b-2f51d84b22e0' AND activeflag = 1;
