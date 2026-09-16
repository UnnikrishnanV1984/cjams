ALTER TABLE defecttracking.cjamsjiratickets
ADD COLUMN IF NOT EXISTS cjamscreatedby character varying,
ADD COLUMN IF NOT EXISTS cjamsreportedby character varying,
ADD COLUMN IF NOT EXISTS cjamscounty character varying,
ADD COLUMN IF NOT EXISTS cdmcreatedby character varying,
ADD COLUMN IF NOT EXISTS cdmreportedby character varying,
ADD COLUMN IF NOT EXISTS cdmcounty character varying;

COMMENT ON COLUMN defecttracking.cjamsjiratickets.cjamscreatedby IS 'JIRA CJAMS Ticket Created By';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cjamsreportedby IS 'JIRA CJAMS Ticket Reported By';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cjamscounty IS 'JIRA CJAMS Ticket County';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cdmcreatedby IS 'JIRA CDM Ticket Created By';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cdmreportedby IS 'JIRA CDM Ticket Repored By';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cdmcounty IS 'JIRA CDM Ticket County';
