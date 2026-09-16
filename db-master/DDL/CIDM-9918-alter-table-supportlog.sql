--CIDM-9918 Added new columns for sending "Approved By(approvedsupervisorid)" and "Default Supervisor(caseworkerdefaultsupervisorid)" values during jira creation through contact support--

ALTER TABLE defecttracking.supportlog ADD COLUMN IF NOT EXISTS approvedsupervisorid uuid;
COMMENT ON COLUMN defecttracking.supportlog.approvedsupervisorid IS 'Support log Approved Supervisor id';
ALTER TABLE defecttracking.supportlog ADD COLUMN IF NOT EXISTS caseworkerdefaultsupervisorid  uuid;
COMMENT ON COLUMN defecttracking.supportlog.caseworkerdefaultsupervisorid IS 'Default Supervisor ID of the caseworker who created support log';
