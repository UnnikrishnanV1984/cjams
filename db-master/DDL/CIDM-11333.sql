-- Table: cjams.emailjavabatchnotify
DROP TABLE IF EXISTS cjams.emailjavabatchnotify;
CREATE TABLE IF NOT EXISTS cjams.emailjavabatchnotify (
    emailjavabatchnotifyid UUID PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
    objecttype VARCHAR(100) NULL,
    objectid UUID NULL,
    toemail VARCHAR(255) NULL,
    body TEXT NULL,
    subject TEXT NULL,
    response TEXT NULL,
    responsestatus VARCHAR(50) NULL,
    insertedon TIMESTAMP NOT NULL DEFAULT NOW(),
    insertedby VARCHAR(50) NOT NULL,
    updatedon TIMESTAMP NOT NULL DEFAULT NOW(),
    updatedby VARCHAR(50) NOT NULL,
    emailstatus INTEGER NULL,
    activeflag INTEGER NOT NULL DEFAULT 1
);
COMMENT ON COLUMN cjams.emailjavabatchnotify.emailjavabatchnotifyid IS 'Unique ID for each batch email notification record';
COMMENT ON COLUMN cjams.emailjavabatchnotify.objecttype IS 'Type of object associated with the email';
COMMENT ON COLUMN cjams.emailjavabatchnotify.objectid IS 'Unique identifier of the associated object';
COMMENT ON COLUMN cjams.emailjavabatchnotify.toemail IS 'Recipient email address';
COMMENT ON COLUMN cjams.emailjavabatchnotify.body IS 'Email body content in HTML/text format';
COMMENT ON COLUMN cjams.emailjavabatchnotify.subject IS 'Email subject line';
COMMENT ON COLUMN cjams.emailjavabatchnotify.response IS 'Response received from email service provider';
COMMENT ON COLUMN cjams.emailjavabatchnotify.responsestatus IS 'Status of email delivery (e.g., success, failure)';
COMMENT ON COLUMN cjams.emailjavabatchnotify.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.emailjavabatchnotify.insertedby IS 'User or system who created this record';
COMMENT ON COLUMN cjams.emailjavabatchnotify.updatedon IS 'Record last updated date and time';
COMMENT ON COLUMN cjams.emailjavabatchnotify.updatedby IS 'User or system who last updated this record';
COMMENT ON COLUMN cjams.emailjavabatchnotify.emailstatus IS 'Email processing status: 0 = Failed, 1 = Success';
COMMENT ON COLUMN cjams.emailjavabatchnotify.activeflag IS 'Indicates whether the record is active (1 = Active, 0 = Inactive)';


-- Table: cjams.emailjavabatchnotify_history
DROP TABLE IF EXISTS cjams.emailjavabatchnotify_history;
CREATE TABLE IF NOT EXISTS cjams.emailjavabatchnotify_history (
    emailjavabatchnotifyhistoryid  UUID PRIMARY KEY DEFAULT gen_random_uuid()  NOT NULL,
    LIKE cjams.emailjavabatchnotify INCLUDING DEFAULTS INCLUDING COMMENTS
);
COMMENT ON TABLE cjams.emailjavabatchnotify_history IS 'History table for emailjavabatchnotify storing individual email execution records.';