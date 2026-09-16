DROP TABLE IF EXISTS defecttracking.cjamsjiratickets;
CREATE TABLE defecttracking.cjamsjiratickets (
	cjamsjiraticketsid 		uuid 		NOT NULL DEFAULT gen_random_uuid(),
	supportnumber 			character varying,
	title					character varying,
	cjamsticketnumber 		character varying,
	cjamsticketstatus 		character varying,
	cjamsticketcreateddate 	date,
	cdmticketnumber 		character varying,
	cdmticketstatus 		character varying,
	cdmticketcreateddate 	date,
	component 				character varying,
	subcomponent 			character varying,	
	lastcomments			text,
	focusarea 				character varying,
	resolution 				character varying,
	fixtype					character varying,
	resolutioncomments 		character varying,
	lastupdatedate 			date,
	activeflag 				int4 		NOT NULL DEFAULT 1,
	insertedby 				character varying NOT NULL,
	insertedon 				timestamp 	NOT NULL DEFAULT now(),
	updatedby 				character varying,
	updatedon 				timestamp,
	CONSTRAINT pk_cjamsjiratickets PRIMARY KEY (cjamsjiraticketsid)
);


COMMENT ON COLUMN defecttracking.cjamsjiratickets.cjamsjiraticketsid IS 'Primary key for the table';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.supportnumber IS 'CJAMS Support Number for JIRA Ticket';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.title IS 'JIRA Ticket title or summary';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cjamsticketnumber IS 'CJAMS Ticket Number';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cjamsticketstatus IS 'CJAMS Ticket Status';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cjamsticketcreateddate IS 'CJAMS Ticket Created Date in JIRA';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cdmticketnumber IS 'CDM Ticket Number';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cdmticketstatus IS 'CDM Ticket Status';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cdmticketcreateddate IS 'CDM Ticket Created Date in JIRA';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.component IS 'Application Name';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.subcomponent IS 'Area impacted in apllication';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.lastcomments IS 'Latest Comments in JIRA Ticket';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.focusarea IS 'Focus Area of the ticket in JIRA';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.resolution IS 'Resolution of the ticket in JIRA';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.fixtype IS 'Fix Type Implemented';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.resolutioncomments IS 'Resolution Comments of the ticket in JIRA';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.lastupdatedate IS 'CDM Ticket Last Update Date';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.activeflag IS 'Status of the record';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.insertedby IS 'User who inserted the record';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.insertedon IS 'Record inserted Date';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.updatedby IS 'User who updated the record';
COMMENT ON COLUMN defecttracking.cjamsjiratickets.updatedon IS 'Record updated date';

CREATE INDEX cjamsjiratickets_supportnumber_idx ON defecttracking.cjamsjiratickets USING btree (supportnumber);
CREATE INDEX cjamsjiratickets_cjamsticketnumber_idx ON defecttracking.cjamsjiratickets USING btree (cjamsticketnumber);
CREATE INDEX cjamsjiratickets_cdmticketnumber_idx ON defecttracking.cjamsjiratickets USING btree (cdmticketnumber);