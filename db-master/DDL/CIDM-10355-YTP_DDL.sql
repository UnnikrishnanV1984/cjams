ALTER TABLE cjams.youthtransitionplan
ADD COLUMN IF NOT EXISTS copyofplanjson jsonb NULL,
ADD COLUMN IF NOT EXISTS startdate TIMESTAMP NULL,
ADD COLUMN IF NOT EXISTS enddate TIMESTAMP NULL;

COMMENT ON COLUMN cjams.youthtransitionplan.copyofplanjson IS 'Stores JSON copy values of the copied Youth Transition Plan information for record-keeping or archival purposes.';
COMMENT ON COLUMN cjams.youthtransitionplan.startdate IS 'The planned start date and time for the youth transition plan';
COMMENT ON COLUMN cjams.youthtransitionplan.enddate IS 'The planned end date and time for the youth transition plan';