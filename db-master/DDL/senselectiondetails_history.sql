-- CIDM-10502 - Create the SEN History Revision table with all necessary fields to track sen flag sen check and uncheck status
CREATE TABLE IF NOT EXISTS cjams.senselectiondetails_history (
  senselectiondetailshistoryid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  senselectiondetailsid UUID NOT NULL
    REFERENCES cjams.senselectiondetails(senselectiondetailsid)
    ON DELETE CASCADE,
  personid uuid,
  requestedby VARCHAR(255) NOT NULL,
  senstatus BOOLEAN,
  approvalstatus VARCHAR(50) NOT NULL,
  denialreasonkey VARCHAR(50) NULL,
  denialreasondesc VARCHAR(1000) NULL,
  reasons TEXT[],
  otherreason TEXT,
  actions TEXT[],
  substanceclasses TEXT[],
  objectid uuid,
  requestedon TIMESTAMP WITHOUT TIME ZONE,
  processedon TIMESTAMP WITHOUT TIME ZONE,
  approvedby VARCHAR(255),
  approvedon TIMESTAMP WITHOUT TIME ZONE,
  insertedby VARCHAR(255),
  insertedon TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updatedby VARCHAR(255),
  updatedon TIMESTAMP WITHOUT TIME ZONE,
  activeflag SMALLINT
);

-- Add indexes
CREATE INDEX IF NOT EXISTS idx_senhistory_personid ON cjams.senselectiondetails_history(personid);
CREATE INDEX IF NOT EXISTS idx_senhistory_main_fk ON cjams.senselectiondetails_history(senselectiondetailsid);

-- Comments on history table columns
COMMENT ON COLUMN cjams.senselectiondetails_history.senselectiondetailshistoryid IS 'UUID primary key for SEN selection history revision record';
COMMENT ON COLUMN cjams.senselectiondetails_history.senselectiondetailsid IS 'Foreign key reference to main SEN selection record';
COMMENT ON COLUMN cjams.senselectiondetails_history.personid IS 'Person ID tied to this SEN revision';
COMMENT ON COLUMN cjams.senselectiondetails_history.requestedby IS 'User who made the request';
COMMENT ON COLUMN cjams.senselectiondetails_history.senstatus IS 'Status of SEN flag during this revision';
COMMENT ON COLUMN cjams.senselectiondetails_history.approvalstatus IS 'State of the revision (Review, Approved, Rejected)';
COMMENT ON COLUMN cjams.senselectiondetails_history.denialreasonkey IS 'Key representing the selected denial reason for SEN approval';
COMMENT ON COLUMN cjams.senselectiondetails_history.denialreasondesc IS 'Detailed description or explanation for the denial of SEN approval';
COMMENT ON COLUMN cjams.senselectiondetails_history.reasons IS 'Reasons for removal (array)';
COMMENT ON COLUMN cjams.senselectiondetails_history.otherreason IS 'Free text for custom reasons';
COMMENT ON COLUMN cjams.senselectiondetails_history.actions IS 'Agency actions logged';
COMMENT ON COLUMN cjams.senselectiondetails_history.substanceclasses IS 'Substance classifications (array)';
COMMENT ON COLUMN cjams.senselectiondetails_history.objectid IS 'Related service/intake ID';
COMMENT ON COLUMN cjams.senselectiondetails_history.requestedon IS 'When the revision request was made';
COMMENT ON COLUMN cjams.senselectiondetails_history.processedon IS 'When the revision was processed';
COMMENT ON COLUMN cjams.senselectiondetails_history.approvedby IS 'Approver of this revision';
COMMENT ON COLUMN cjams.senselectiondetails_history.approvedon IS 'When the revision was approved';
COMMENT ON COLUMN cjams.senselectiondetails_history.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.senselectiondetails_history.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.senselectiondetails_history.updatedby IS 'User who last updated this revision';
COMMENT ON COLUMN cjams.senselectiondetails_history.updatedon IS 'Timestamp of last update';
COMMENT ON COLUMN cjams.senselectiondetails_history.activeflag IS 'Revision active status: 0=Inactive, 1=Active, 2=Pending';