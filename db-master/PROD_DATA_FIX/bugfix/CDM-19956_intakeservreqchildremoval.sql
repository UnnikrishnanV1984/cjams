/*
-- Issue Description: 
-- CDM-19956: Maddox Howard(200662311)
-- Category/ Module: Child Removal ive
-- Root cause: case approval for an YTP is still in approval box though it is approved
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

UPDATE cjams.intakeservreqchildremoval
SET  updatedby='CDM-19956', updatedon=now(), intakeservicerequestactorid='5eee9c87-cc47-4bba-bfc2-79a7a5d5bf9c'
WHERE intakeservreqchildremovalid='1663f735-adc8-4ca0-ae85-fddb51da6b85' and removalid=251146;
