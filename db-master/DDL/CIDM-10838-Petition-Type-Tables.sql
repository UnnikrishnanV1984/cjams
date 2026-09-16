DROP TABLE IF EXISTS cjams.apgtpetitionchildren;
DROP TABLE IF EXISTS cjams.apgtpetition;

-- apgtpetition
CREATE TABLE cjams.apgtpetition (
  apgtpetitionid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  intakeservicerequestpetitionid UUID NOT NULL,
  activeflag SMALLINT NOT NULL,
  insertedby VARCHAR(100) NOT NULL,
  insertedon TIMESTAMP NOT NULL DEFAULT now(),
  updatedby VARCHAR(100),
  updatedon TIMESTAMP
);

-- Index
CREATE INDEX idx_apgtpetition_isrpetition
  ON cjams.apgtpetition (intakeservicerequestpetitionid)
  WHERE activeflag = 1;


  COMMENT ON COLUMN cjams.apgtpetition.apgtpetitionid
IS 'Primary key for APGT petition record';

COMMENT ON COLUMN cjams.apgtpetition.intakeservicerequestpetitionid
IS 'Reference to intake service request petition ID';

COMMENT ON COLUMN cjams.apgtpetition.activeflag
IS 'Indicates if the record is active';

COMMENT ON COLUMN cjams.apgtpetition.insertedby
IS 'User who inserted the record';

COMMENT ON COLUMN cjams.apgtpetition.insertedon
IS 'Timestamp when the record was inserted';

COMMENT ON COLUMN cjams.apgtpetition.updatedby
IS 'User who last updated the record';

COMMENT ON COLUMN cjams.apgtpetition.updatedon
IS 'Timestamp when the record was last updated';



-- apgtpetitionchildren
CREATE TABLE cjams.apgtpetitionchildren (
  apgtpetitionchildrenid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  apgtpetitionid UUID NOT NULL,
  intakeservicerequestactorid UUID NOT NULL,
  personid UUID NOT NULL,
  firstcertificationdate DATE,
  disabilitynarrative TEXT,
  vabenefits BOOLEAN,
  secondcertificationappointment DATE,
  interestedpersons jsonb NULL,
  placementid uuid NULL,
  secondcertificationbyactorid UUID,
  vabenefitscomment TEXT,
  financialsummary TEXT,
  activeflag SMALLINT NOT NULL DEFAULT 1,
  insertedby VARCHAR(100) NOT NULL,
  insertedon TIMESTAMP NOT NULL DEFAULT now(),
  updatedby VARCHAR(100),
  updatedon TIMESTAMP,

  CONSTRAINT fk_apgtpetitionchildren_parent
    FOREIGN KEY (apgtpetitionid)
    REFERENCES cjams.apgtpetition(apgtpetitionid)
);

CREATE INDEX idx_apgtpetitionchildren_parent
  ON cjams.apgtpetitionchildren (apgtpetitionid)
  WHERE activeflag = 1;



COMMENT ON COLUMN cjams.apgtpetitionchildren.apgtpetitionchildrenid
IS 'Primary key for APGT petition child record';

COMMENT ON COLUMN cjams.apgtpetitionchildren.apgtpetitionid
IS 'Reference to parent APGT petition';

COMMENT ON COLUMN cjams.apgtpetitionchildren.intakeservicerequestactorid
IS 'Actor ID associated with the intake service request';

COMMENT ON COLUMN cjams.apgtpetitionchildren.personid
IS 'Person ID of the child associated with the petition';

COMMENT ON COLUMN cjams.apgtpetitionchildren.firstcertificationdate
IS 'Date of the first certification';

COMMENT ON COLUMN cjams.apgtpetitionchildren.disabilitynarrative
IS 'Narrative describing disability details';

COMMENT ON COLUMN cjams.apgtpetitionchildren.vabenefits
IS 'Indicates if VA benefits are received';

COMMENT ON COLUMN cjams.apgtpetitionchildren.vabenefitscomment
IS 'Comments related to VA benefits';

COMMENT ON COLUMN cjams.apgtpetitionchildren.financialsummary
IS 'Summary of financial details';

COMMENT ON COLUMN cjams.apgtpetitionchildren.secondcertificationbyactorid
IS 'Actor ID who performed the second certification';

COMMENT ON COLUMN cjams.apgtpetitionchildren.secondcertificationappointment
IS 'Date of the second certification appointment';

COMMENT ON COLUMN cjams.apgtpetitionchildren.interestedpersons
IS 'To save interested persons data, their address and telephone number';

COMMENT ON COLUMN cjams.apgtpetitionchildren.placementid
IS 'To Save Placement ID';

COMMENT ON COLUMN cjams.apgtpetitionchildren.activeflag
IS 'Indicates if the record is active';

COMMENT ON COLUMN cjams.apgtpetitionchildren.insertedby
IS 'User who inserted the record';

COMMENT ON COLUMN cjams.apgtpetitionchildren.insertedon
IS 'Timestamp when the record was inserted';

COMMENT ON COLUMN cjams.apgtpetitionchildren.updatedby
IS 'User who last updated the record';

COMMENT ON COLUMN cjams.apgtpetitionchildren.updatedon
IS 'Timestamp when the record was last updated';