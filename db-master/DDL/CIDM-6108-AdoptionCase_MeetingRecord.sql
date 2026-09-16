------------------------------------------------------------------------
-- DDL Changes
-- Author: Vigneshwar Kumar
-- Date Created :  02/17/2023 
-- DML Changes to support AdoptionCase Family Involvement Meeting(CIDM-6108)

-- Revision(s)
------------------------------------------------------------------------  

ALTER TABLE cjams.meetingrecordingactor ADD adoptioncaseactorid uuid NULL;
COMMENT ON COLUMN cjams.meetingrecordingactor.adoptioncaseactorid IS 'Person actor type id (foreing key)';
ALTER TABLE cjams.meetingrecordingactor ALTER COLUMN intakeservicerequestactorid DROP NOT NULL;

ALTER TABLE cjams.meetingrecording ADD adoptioncaseid uuid NULL;
COMMENT ON COLUMN cjams.meetingrecording.adoptioncaseid IS 'adoptioncaseid(foreign key)';