/*
   Issue Description: CIDM-5024
   Category/ Module  : Safe care plan in Person Tab
*/

DROP TABLE IF EXISTS cjams.safecareplan;

CREATE TABLE cjams.safecareplan (
	safecareplanid uuid NOT NULL DEFAULT gen_random_uuid(),
	objectid character varying,
	objecttypekey character varying, 
	safecaredate date,
	persondetails json, -- Section 1
	planparticipants json,  -- Section 2
	healthneedsdetails json,  -- Section 3
	otherservices json,  -- Section 4
	planreviewdetails json,  -- Section 5
	comments character varying, -- Section 6
	justification character varying,
	consentform json, -- Section 7
	recommendedforclosure boolean,
	insufficientevidencetocourt boolean,
	familypreservationtransfer boolean,
	referredtocps boolean,
	shelterorder boolean,
	signatures json,
	activeflag integer NOT NULL DEFAULT 1,
	insertedby uuid NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby uuid NULL,
	updatedon timestamp NULL DEFAULT now(),
	approvalstatus character varying(20),
	CONSTRAINT pk_safecareplan PRIMARY KEY (safecareplanid)
);

DROP TABLE IF EXISTS cjams.safecareplan_history;

CREATE TABLE cjams.safecareplan_history (
	safecareplanhistoryid uuid NOT NULL DEFAULT gen_random_uuid(),
	safecareplanhistorytype character varying,
	safecareplanid uuid NOT NULL,
	objectid character varying,
	objecttypekey character varying, 
    safecaredate date,
	persondetails json, -- Section 1
	planparticipants json,  -- Section 2
	healthneedsdetails json,  -- Section 3
	otherservices json,  -- Section 4
	planreviewdetails json,  -- Section 5
	comments character varying, -- Section 6
	justification character varying,
	consentform json, -- Section 7
	recommendedforclosure boolean,
	insufficientevidencetocourt boolean,
	familypreservationtransfer boolean,
	referredtocps boolean,
	shelterorder boolean,
	signatures json,
	activeflag integer NOT NULL DEFAULT 1,
	insertedby uuid NULL, 
	insertedon timestamp NULL DEFAULT now(),
	updatedby uuid NULL, 
	updatedon timestamp NULL DEFAULT now(),
	approvalstatus character varying(20),
	CONSTRAINT pk_safecareplanhistory PRIMARY KEY (safecareplanhistoryid)
);


-- Comments for safecareplan
COMMENT ON COLUMN cjams.safecareplan.safecareplanid IS 'Unique identifier of this table (Primary Key)';
COMMENT ON COLUMN cjams.safecareplan.objectid IS 'Case unique id';
COMMENT ON COLUMN cjams.safecareplan.objecttypekey IS 'Type of Case';
COMMENT ON COLUMN cjams.safecareplan.safecaredate  IS 'Date of the safe care plan';
COMMENT ON COLUMN cjams.safecareplan.persondetails IS 'Info of new born and family invloved in the safe care plan';
COMMENT ON COLUMN cjams.safecareplan.planparticipants IS 'Info of participants in the safe care plan';
COMMENT ON COLUMN cjams.safecareplan.healthneedsdetails IS 'Info of health needs';
COMMENT ON COLUMN cjams.safecareplan.otherservices IS 'Other details';
COMMENT ON COLUMN cjams.safecareplan.planreviewdetails IS 'Safe care plan review information';
COMMENT ON COLUMN cjams.safecareplan.comments IS 'Additional comment by case worker';
COMMENT ON COLUMN cjams.safecareplan.justification IS 'Justification for approve/reject by supervisor';
COMMENT ON COLUMN cjams.safecareplan.consentform IS 'Consent form info for the safe care plan';
COMMENT ON COLUMN cjams.safecareplan.recommendedforclosure IS 'Boolean flag to store the case is recommended for closure';
COMMENT ON COLUMN cjams.safecareplan.insufficientevidencetocourt IS 'Boolean flag to check the court evidence is insufficient';
COMMENT ON COLUMN cjams.safecareplan.familypreservationtransfer IS 'Boolean flag to check the transfer made for family preservation';
COMMENT ON COLUMN cjams.safecareplan.referredtocps IS 'Boolean flag to check the transfer made for family preservation';
COMMENT ON COLUMN cjams.safecareplan.shelterorder IS 'Boolean flag for court shelter order action';
COMMENT ON COLUMN cjams.safecareplan.signatures IS 'Signatures of parents, caregiver, case worker and supervisor';
COMMENT ON COLUMN cjams.safecareplan.activeflag IS 'Status of the record';
COMMENT ON COLUMN cjams.safecareplan.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.safecareplan.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.safecareplan.updatedby IS 'User who last updated the record';
COMMENT ON COLUMN cjams.safecareplan.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.safecareplan.approvalstatus IS 'Record approval status';


-- Comments for safecareplan_history
COMMENT ON COLUMN cjams.safecareplan_history.safecareplanhistoryid IS 'Unique identifier of this table (Primary Key)';
COMMENT ON COLUMN cjams.safecareplan_history.objectid IS 'Case unique id';
COMMENT ON COLUMN cjams.safecareplan_history.objecttypekey IS 'Type of Case';
COMMENT ON COLUMN cjams.safecareplan_history.safecaredate  IS 'Date of the safe care plan';
COMMENT ON COLUMN cjams.safecareplan_history.safecareplanid IS 'Safe care plan identifier';
COMMENT ON COLUMN cjams.safecareplan_history.persondetails IS 'Info of new born and family invloved in the safe care plan';
COMMENT ON COLUMN cjams.safecareplan_history.planparticipants IS 'Info of participants in the safe care plan';
COMMENT ON COLUMN cjams.safecareplan_history.healthneedsdetails IS 'Info of health needs';
COMMENT ON COLUMN cjams.safecareplan_history.otherservices IS 'Other details';
COMMENT ON COLUMN cjams.safecareplan_history.planreviewdetails IS 'Safe care plan review information';
COMMENT ON COLUMN cjams.safecareplan_history.comments IS 'Additional comment by case worker';
COMMENT ON COLUMN cjams.safecareplan_history.justification IS 'Justification for approve/reject by supervisor';
COMMENT ON COLUMN cjams.safecareplan_history.consentform IS 'Consent form info for the safe care plan';
COMMENT ON COLUMN cjams.safecareplan_history.recommendedforclosure IS 'Boolean flag to store the case is recommended for closure';
COMMENT ON COLUMN cjams.safecareplan_history.insufficientevidencetocourt IS 'Boolean flag to check the court evidence is insufficient';
COMMENT ON COLUMN cjams.safecareplan_history.familypreservationtransfer IS 'Boolean flag to check the transfer made for family preservation';
COMMENT ON COLUMN cjams.safecareplan_history.referredtocps IS 'Boolean flag to check the transfer made for family preservation';
COMMENT ON COLUMN cjams.safecareplan_history.shelterorder IS 'Boolean flag for court shelter order action';
COMMENT ON COLUMN cjams.safecareplan_history.signatures IS 'Signatures of parents, caregiver, case worker and supervisor';
COMMENT ON COLUMN cjams.safecareplan_history.activeflag IS 'Status of the record';
COMMENT ON COLUMN cjams.safecareplan_history.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.safecareplan_history.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.safecareplan_history.updatedby IS 'User who last updated the record';
COMMENT ON COLUMN cjams.safecareplan_history.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.safecareplan_history.approvalstatus IS 'Record approval status';


