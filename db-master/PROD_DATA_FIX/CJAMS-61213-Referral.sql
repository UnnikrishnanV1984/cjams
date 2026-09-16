/*
-- Issue Description: 
	I251013331153:Erroneously entered case - remove intake
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
    updatedby = 'CJAMS-61213', 
    updatedon = now()
WHERE intakenumber = 'I251013331153' AND activeflag = 1;

-- Update intakedastatus
UPDATE intakedastatus
SET activeflag = 0,
    updatedby = 'CJAMS-61213',
    updatedon = now()
WHERE intakenumber = 'I251013331153' AND activeflag = 1;

-- Update actor
UPDATE actor
SET activeflag = 0,
    updatedby = 'CJAMS-61213',
    updatedon = now()
WHERE intakenumber = 'I251013331153' AND activeflag = 1;

-- Update intakeservicerequestactor
UPDATE intakeservicerequestactor
SET activeflag = 0,
    updatedby = 'CJAMS-61213',
    updatedon = now()
WHERE intakenumber = 'I251013331153' AND activeflag = 1;

-- Update personrole
--select * from personrole where intakenumber = 'I251013331153'

UPDATE personrole
SET activeflag = 0,
    updatedby = 'CJAMS-61213',
    updatedon = now()
WHERE intakenumber = 'I251013331153' AND activeflag = 1;

-- Update personroletype
UPDATE personroletype
SET activeflag = 0,
    updatedby = 'CJAMS-61213',
    updatedon = now()
where personroleid in ('495f70dc-fbf6-44d3-b303-a2dbb6a18c3c',
'91948b5d-feb4-4af5-a63b-37d9a697706a',
'ad1d3b1b-6f74-40bc-8ea2-68749b77728a',
'e6f52032-e5a0-4d09-be94-41b81422d682',
'9787d40a-2582-429f-8374-0f3571ef9994',
'7ff6e1b9-814a-4045-9f75-7b1e9c6d90f8',
'95920686-30f0-4b8b-b0a6-7273afc9f85b',
'0d865143-a0c4-46ac-beb2-c1e4489e2d08') AND activeflag = 1;
