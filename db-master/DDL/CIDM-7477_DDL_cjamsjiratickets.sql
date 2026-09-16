ALTER TABLE defecttracking.cjamsjiratickets
ADD COLUMN IF NOT EXISTS cjamslastupdateddate date,
ADD COLUMN IF NOT EXISTS cjamsresolutiondate date,
ADD COLUMN IF NOT EXISTS cjamscloseddate date,
ADD COLUMN IF NOT EXISTS cdmlastupdateddate date,
ADD COLUMN IF NOT EXISTS cdmresolutiondate date,
ADD COLUMN IF NOT EXISTS cdmcloseddate date;

COMMENT ON COLUMN defecttracking.cjamsjiratickets.cjamslastupdateddate IS 'CJAMS Ticket Last Updated Date';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cjamsresolutiondate IS 'CJAMS Ticket Resolution Date';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cjamscloseddate IS 'CJAMS Ticket Closed Date';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cdmlastupdateddate IS 'CDM Ticket Last Updated Date';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cdmresolutiondate IS 'CDM Ticket Resolution Date';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cdmcloseddate IS 'CDM Ticket Closed Date';

ALTER TABLE defecttracking.supportlog
	ADD COLUMN IF NOT EXISTS approveddate DATE,
	ADD COLUMN IF NOT EXISTS rejecteddate DATE,
	ADD COLUMN IF NOT EXISTS cjamsticketstatus 		CHARACTER VARYING,
	ADD COLUMN IF NOT EXISTS cjamsticketcreateddate DATE,
	ADD COLUMN IF NOT EXISTS cjamslastupdateddate 	DATE,
	ADD COLUMN IF NOT EXISTS cjamsresolutiondate 		DATE,
	ADD COLUMN IF NOT EXISTS cjamscloseddate 		DATE,
	ADD COLUMN IF NOT EXISTS cdmticketstatus 		CHARACTER VARYING,
	ADD COLUMN IF NOT EXISTS cdmticketcreateddate 	DATE,
	ADD COLUMN IF NOT EXISTS cdmlastupdateddate 	DATE,
	ADD COLUMN IF NOT EXISTS cdmresolutiondate 		DATE,
	ADD COLUMN IF NOT EXISTS cdmcloseddate 			DATE,
	ADD COLUMN IF NOT EXISTS fixtype 				CHARACTER VARYING,
	ADD COLUMN IF NOT EXISTS resolutioncomments 	CHARACTER VARYING;
	
COMMENT ON COLUMN defecttracking.supportlog.approveddate IS 'Support Ticket Approved Date';
COMMENT ON COLUMN defecttracking.supportlog.rejecteddate IS 'Support Ticket Rejected Date';
COMMENT ON COLUMN defecttracking.supportlog.cjamsticketstatus IS 'CJAMS Ticket Status';
COMMENT ON COLUMN defecttracking.supportlog.cjamsticketcreateddate IS 'CJAMS Ticket Created Date';
COMMENT ON COLUMN defecttracking.supportlog.cjamslastupdateddate IS 'CJAMS Ticket Last Updated Date';
COMMENT ON COLUMN defecttracking.supportlog.cjamsresolutiondate IS 'CJAMS Ticket Resolved Date';
COMMENT ON COLUMN defecttracking.supportlog.cjamscloseddate IS 'CJAMS Ticket Closed Date';
COMMENT ON COLUMN defecttracking.supportlog.cdmticketstatus IS 'CDM Ticket Status';
COMMENT ON COLUMN defecttracking.supportlog.cdmticketcreateddate IS 'CDM Ticket Created Date';
COMMENT ON COLUMN defecttracking.supportlog.cdmlastupdateddate IS 'CDM Ticket Last Updated Date';
COMMENT ON COLUMN defecttracking.supportlog.cdmresolutiondate IS 'CDM Ticket Resolved Date';
COMMENT ON COLUMN defecttracking.supportlog.cdmcloseddate IS 'CDM Ticket Closed Date';
COMMENT ON COLUMN defecttracking.supportlog.fixtype IS 'JIRA Ticket Fix Type';
COMMENT ON COLUMN defecttracking.supportlog.resolutioncomments IS 'JIRA Ticket Resolution Comments';