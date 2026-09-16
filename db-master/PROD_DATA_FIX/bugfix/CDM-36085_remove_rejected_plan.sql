-- CDM-36085 - Remove rejected Permanency Plan/*
-- Issue Description: Please do the data fix to delete the the following rejected Permanency Plan as its appearing in case plan
-- Category/ Module: permanencyplan
-- Root cause: Rejected plan needs to be deleted as per user request
-- Fix Provided: To soft delete placement from placement table
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
UPDATE
    cjams.placement
SET
    activeflag = 0,
    updatedby = 'CDM-36085',
    updatedon = now()
WHERE
    placementid = '2cc8bb6b-c897-4bd0-b443-a014bb60c570'
    and activeflag = 1;

UPDATE
    cjams.placementrevision
SET
    activeflag = 0,
    updatedby = 'CDM-36085',
    updatedon = now()
WHERE
    placementid = '2cc8bb6b-c897-4bd0-b443-a014bb60c570'
    and activeflag = 1;

UPDATE
    cjams.livingarrangement
SET
    activeflag = 0,
    updatedby = 'CDM-36085',
    updatedon = now()
WHERE
    placementid = '2cc8bb6b-c897-4bd0-b443-a014bb60c570'
    and activeflag = 1;

UPDATE
    cjams.routing
SET
    activeflag = 0,
    updatedby = 'CDM-36085',
    updatedon = now()
where
    objectid = '2cc8bb6b-c897-4bd0-b443-a014bb60c570'
    and activeflag = 1;