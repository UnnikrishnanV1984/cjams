-------------------------------------------------------------------------------------------------------
-- CIDM-10473 - B-173471 1080 Form B
------------------------------------------------------------------------------------------------------- 

DROP TABLE IF EXISTS cjams.form1080b;

CREATE TABLE
	IF NOT EXISTS cjams.form1080b (
		form1080bid uuid NOT NULL DEFAULT gen_random_uuid (),
		objectid character varying,
		objecttype character varying,
		casenumber character varying,
		personid uuid,
		provideasummaryoftheinvestigationandidentifyanybarriestheldss character varying,
		whatisthemedicalexaminerspreliminaryfinding character varying,
		signatureofpersoncompletingthisreport character varying,
		datecompleted timestamp with time zone,
		submitforapproval character varying,
		supervisorcomments character varying,
		status character varying,
		activeflag int4 NOT NULL DEFAULT 1,
		insertedby varchar(50) NOT NULL,
		insertedon timestamp NOT NULL DEFAULT now (),
		updatedby varchar(50) NOT NULL,
		updatedon timestamp NOT NULL DEFAULT now (),
		copyofform1080b jsonb NULL,
		CONSTRAINT pk_form1080b PRIMARY KEY (form1080bid),
		CONSTRAINT fk_form1080b_person FOREIGN KEY (personid) REFERENCES cjams.person (personid)
	);

COMMENT ON COLUMN cjams.form1080b.form1080bid IS 'Unique identifier for the form1080b (primary key).';
COMMENT ON COLUMN cjams.form1080b.objectid IS 'Unique identifier for the object within the system.';
COMMENT ON COLUMN cjams.form1080b.objecttype IS 'Reference key used to link the object to related data.';
COMMENT ON COLUMN cjams.form1080b.casenumber IS 'Unique identifier assigned to the case for tracking and reference.';
COMMENT ON COLUMN cjams.form1080b.personid IS 'Personid is the link thats established with the person table';
COMMENT ON COLUMN cjams.form1080b.provideasummaryoftheinvestigationandidentifyanybarriestheldss IS 'Summary of the investigation conducted and any barriers encountered by LDSS.';
COMMENT ON COLUMN cjams.form1080b.whatisthemedicalexaminerspreliminaryfinding IS 'Initial findings from the medical examiner regarding the incident.';
COMMENT ON COLUMN cjams.form1080b.signatureofpersoncompletingthisreport IS 'Signature of the individual responsible for completing the report.';
COMMENT ON COLUMN cjams.form1080b.datecompleted IS 'Date when the report was completed.';
COMMENT ON COLUMN cjams.form1080b.activeflag IS 'Indicates whether the form1080b is active (1 for active, 0 for inactive).';
COMMENT ON COLUMN cjams.form1080b.updatedby IS 'The user who last updated the form1080b information.';
COMMENT ON COLUMN cjams.form1080b.updatedon IS 'Timestamp of the last update to the form1080b record.';
COMMENT ON COLUMN cjams.form1080b.insertedby IS 'The user who initially inserted the form1080b record.';
COMMENT ON COLUMN cjams.form1080b.insertedon IS 'Timestamp of when the form1080b record was first inserted.';
COMMENT ON COLUMN cjams.form1080b.copyofform1080b IS 'Stores JSON copy values of the copied form 1080b information for record-keeping or archival purposes.';