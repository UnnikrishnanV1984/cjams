/*
   Description: CIDM-5026 (B-130715) TPR User Story
   Category/ Module  : adding person type to store unknown parent details
*/

ALTER TABLE cjams.tprdetails DROP CONSTRAINT IF EXISTS fk_tprdetails_intakeservicerequestactor;
ALTER TABLE cjams.tprdetails ADD column if not exists persontype varchar(50);

COMMENT ON COLUMN cjams.tprdetails.persontype IS 'person is from person table or otherperson table';