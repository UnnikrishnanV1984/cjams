-- CIDM-10502 - Create SEN History table with all required fields
-- CIDM-10502 - Changed Column names
DROP TABLE IF EXISTS cjams.senselectiondetails_history;
DROP TABLE IF EXISTS cjams.senselectiondetails;
CREATE TABLE IF NOT EXISTS cjams.senselectiondetails (
  senselectiondetailsid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  personid uuid,
  requestedon TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  requestedby VARCHAR(255) NOT NULL,
  approvedby VARCHAR(255),
  approvedon TIMESTAMP,
  senstatus BOOLEAN NOT NULL,
  approvalstatus VARCHAR(50) NOT NULL DEFAULT 'Pending',
  denialreasonkey VARCHAR(50) NULL,
  denialreasondesc VARCHAR(1000) NULL,
  reasons TEXT[],
  otherreason TEXT,
  actions TEXT[],
  substanceclasses TEXT[],
  objectid uuid,
  activeflag SMALLINT,
  insertedby VARCHAR(255),
  insertedon TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updatedby VARCHAR(255),
  updatedon TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Add index for lookup
CREATE INDEX IF NOT EXISTS idx_senselectiondetails_personid ON cjams.senselectiondetails(personid);

-- Comments on main table columns
COMMENT ON COLUMN cjams.senselectiondetails.senselectiondetailsid IS 'UUID primary key for main SEN selection record';
COMMENT ON COLUMN cjams.senselectiondetails.personid IS 'Reference to the person this SEN record belongs to';
COMMENT ON COLUMN cjams.senselectiondetails.requestedon IS 'Timestamp when the SEN request was initiated';
COMMENT ON COLUMN cjams.senselectiondetails.requestedby IS 'User who submitted the SEN request';
COMMENT ON COLUMN cjams.senselectiondetails.approvedby IS 'User who approved the SEN request';
COMMENT ON COLUMN cjams.senselectiondetails.approvedon IS 'Timestamp when the SEN request was approved';
COMMENT ON COLUMN cjams.senselectiondetails.senstatus IS 'Flag indicating if SEN is checked (true) or unchecked (false)';
COMMENT ON COLUMN cjams.senselectiondetails.approvalstatus IS 'Approval status (Pending, Approved, Rejected, etc.)';
COMMENT ON COLUMN cjams.senselectiondetails.denialreasonkey IS 'Key representing the selected denial reason for SEN approval';
COMMENT ON COLUMN cjams.senselectiondetails.denialreasondesc IS 'Detailed description or explanation for the denial of SEN approval';
COMMENT ON COLUMN cjams.senselectiondetails.reasons IS 'Array of reasons for SEN removal';
COMMENT ON COLUMN cjams.senselectiondetails.otherreason IS 'optional other reason text';
COMMENT ON COLUMN cjams.senselectiondetails.actions IS 'Array of agency actions taken';
COMMENT ON COLUMN cjams.senselectiondetails.substanceclasses IS 'Array of substance exposure classifications';
COMMENT ON COLUMN cjams.senselectiondetails.objectid IS 'Reference to the related Servicecase ID';
COMMENT ON COLUMN cjams.senselectiondetails.activeflag IS '0 = Inactive, 1 = Active, 2 = Review state';
COMMENT ON COLUMN cjams.senselectiondetails.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.senselectiondetails.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.senselectiondetails.updatedby IS 'User who last updated the record';
COMMENT ON COLUMN cjams.senselectiondetails.updatedon IS 'Record updated date and time';
