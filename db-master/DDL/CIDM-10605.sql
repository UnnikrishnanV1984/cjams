DROP TABLE IF EXISTS cjams.emaillogs;

CREATE TABLE cjams.emaillogs
(
emaillogsid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
objecttype VARCHAR(50), 
objectid VARCHAR(50),
toemail VARCHAR,
body VARCHAR,
subject VARCHAR,
response VARCHAR,
responsestatus VARCHAR,
insertedon TIMESTAMP NOT NULL DEFAULT NOW(),  -- Timestamp of insertion
insertedby VARCHAR(50) NOT NULL,  -- User who inserted the record
updatedon TIMESTAMP NOT NULL DEFAULT NOW(),  -- Timestamp of last update
updatedby VARCHAR(50),  -- User who last updated the record
activeflag INT4 NOT NULL DEFAULT 1 
);

COMMENT ON COLUMN cjams.emaillogs.responsestatus IS 'Unique identifier response status';
COMMENT ON COLUMN cjams.emaillogs.emaillogsid IS 'Unique identifier for each email log entry';
COMMENT ON COLUMN cjams.emaillogs.emaillogsid IS 'Unique identifier for each email log entry';
COMMENT ON COLUMN cjams.emaillogs.objecttype IS 'Entity type associated with the email (e.g., person, case)';
COMMENT ON COLUMN cjams.emaillogs.objectid IS 'Entity ID related to the email (e.g., personid or caseid)';
COMMENT ON COLUMN cjams.emaillogs.toemail IS 'Recipient email address';
COMMENT ON COLUMN cjams.emaillogs.body IS 'Email body content';
COMMENT ON COLUMN cjams.emaillogs.subject IS 'Email subject line';
COMMENT ON COLUMN cjams.emaillogs.insertedon IS 'Timestamp when the email log was created';
COMMENT ON COLUMN cjams.emaillogs.insertedby IS 'User ID that triggered the email log entry';
COMMENT ON COLUMN cjams.emaillogs.updatedon IS 'Timestamp of the most recent update to the log';
COMMENT ON COLUMN cjams.emaillogs.updatedby IS 'User ID who last updated the log entry';
COMMENT ON COLUMN cjams.emaillogs.activeflag IS 'Indicates if the log is active (1) or soft-deleted/inactive (0)';