
-- 06/05/2026 Surya.arigela --B-244934 CW - Refinement to TPR - Termination of Parental Rights CMT - CIDM-11401
/*
TPR Story

Adding new  columns
*/

ALTER TABLE cjams.intakeservicerequestcourthearing
ADD COLUMN parent1actorid uuid,
ADD COLUMN parent1personid uuid,
ADD COLUMN parent1name varchar(250),
ADD COLUMN parent1unknown boolean DEFAULT false,
ADD COLUMN parent2actorid uuid,
ADD COLUMN parent2personid uuid,
ADD COLUMN parent2name varchar(250),
ADD COLUMN parent2unknown boolean DEFAULT false;

-- Comments for cjams.intakeservicerequestcourthearing for the new columns

COMMENT ON COLUMN cjams.intakeservicerequestcourthearing.parent1actorid
IS 'Stores the intake service request actor ID selected for Parent 1';

COMMENT ON COLUMN cjams.intakeservicerequestcourthearing.parent1personid
IS 'Stores the person ID associated with Parent 1';

COMMENT ON COLUMN cjams.intakeservicerequestcourthearing.parent1name
IS 'Stores the display name of Parent 1';

COMMENT ON COLUMN cjams.intakeservicerequestcourthearing.parent1unknown
IS 'Indicates whether Parent 1 is unknown';

COMMENT ON COLUMN cjams.intakeservicerequestcourthearing.parent2actorid
IS 'Stores the intake service request actor ID selected for Parent 2';

COMMENT ON COLUMN cjams.intakeservicerequestcourthearing.parent2personid
IS 'Stores the person ID associated with Parent 2';

COMMENT ON COLUMN cjams.intakeservicerequestcourthearing.parent2name
IS 'Stores the display name of Parent 2';

COMMENT ON COLUMN cjams.intakeservicerequestcourthearing.parent2unknown
IS 'Indicates whether Parent 2 is unknown';