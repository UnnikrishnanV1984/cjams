ALTER TABLE cjams.personexamination ADD COLUMN IF NOT EXISTS starttime character varying;
ALTER TABLE cjams.personexamination ADD COLUMN IF NOT EXISTS endtime character varying;

ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS starttime character varying;
ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS endtime character varying;

COMMENT ON COLUMN cjams.personhospitalization.starttime
    IS 'This holds the start time of a hospitalization record.';
COMMENT ON COLUMN cjams.personhospitalization.endtime
    IS 'This holds the end time of a hospitalization record.';

COMMENT ON COLUMN cjams.personexamination.starttime
    IS 'This holds the start time of a personexamination record.';
COMMENT ON COLUMN cjams.personexamination.endtime
    IS 'This holds the end time of a personexamination record.';