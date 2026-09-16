ALTER TABLE intakeservreqcourtorder 
ADD COLUMN IF NOT EXISTS dob timestamp without time zone,
ADD COLUMN IF NOT EXISTS county character varying(25),
ADD COLUMN IF NOT EXISTS clientname character varying(50),
ADD COLUMN IF NOT EXISTS personsappeared json,
ADD COLUMN IF NOT EXISTS courtreview character varying(50),
ADD COLUMN IF NOT EXISTS childsneed character varying(250),
ADD COLUMN IF NOT EXISTS childneedcantmet boolean,
ADD COLUMN IF NOT EXISTS childpermanencyplan boolean,
ADD COLUMN IF NOT EXISTS childmosteffplan boolean,
ADD COLUMN IF NOT EXISTS qrtpapproval character varying(50),
ADD COLUMN IF NOT EXISTS qrtpapprovaldecision character varying(50),
ADD COLUMN IF NOT EXISTS judgedate timestamp without time zone,
ADD COLUMN IF NOT EXISTS judgename character varying(50),
ADD COLUMN IF NOT EXISTS judgeid character varying(20),
ADD COLUMN IF NOT EXISTS otherpersonsappeared character varying(50);

COMMENT ON COLUMN cjams.intakeservreqcourtorder.county IS 'County Details for QRTP';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.clientname IS 'Client Details for QRTP';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.dob IS 'Date of Birth changes';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.personsappeared IS 'Client Details for QRTP';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.courtreview IS 'Client Court Details for QRTP';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.childsneed IS 'Client Needs for QRTP';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.childneedcantmet IS 'Child Needs cant met for QRTP';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.childpermanencyplan IS 'Client Details for QRTP';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.childmosteffplan IS 'Client Court Details for QRTP';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.qrtpapproval IS 'QRTP Approval';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.qrtpapprovaldecision IS 'QRTP Decision';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.judgedate IS 'Judge Date Details for QRTP';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.judgename IS 'Judge Details for QRTP';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.judgeid IS 'Judge ID Details for QRTP';
COMMENT ON COLUMN cjams.intakeservreqcourtorder.otherpersonsappeared IS 'otherpersonsappeared for QRTP';