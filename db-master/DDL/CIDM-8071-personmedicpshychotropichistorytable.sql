-- cjams.personmedicpshychotropic_history definition

-- Drop table

DROP TABLE IF EXISTS cjams.personmedicpshychotropic_history;

CREATE TABLE IF NOT EXISTS  cjams.personmedicpshychotropic_history (
    personmedichistoryid uuid NOT NULL DEFAULT gen_random_uuid(),
	rowtype character varying(20),
	personmedicpshychotropicid uuid NOT NULL,
	personid uuid NOT NULL, -- Person id (foreign key)
	medicationname varchar NULL, -- Person Medication Name
	medicationeffectivedate timestamp NULL, -- prescription effectivate date
	medicationexpirationdate timestamp NULL, -- prescription Expiry date
	dosage varchar NULL, --  Person Medication dosage 
	frequency varchar NULL, -- Medication frequency 
	prescribingdoctor varchar NULL, -- Medication prescribingdoctor 
	lastdosetakendate timestamp NULL, -- Medication lastdosetakendate
	medicationcomments varchar NULL, -- medicationcomments
	prescriptionreasontypekey varchar NULL, -- Medication prescriptionreasontypekey
	informationsourcetypekey varchar NULL, -- Medication informationsourcetypekey
	activeflag int4 NOT NULL DEFAULT 1, -- Status of the record
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NULL DEFAULT now(), -- Record updated date and time
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp NULL DEFAULT now(), -- Record created date and time
	effectivedate timestamp NOT NULL DEFAULT now(), -- Record valid from
	expirationdate timestamp NULL, -- Record inactive date
	startdate timestamp NULL, -- Medication startdate 
	enddate timestamp NULL, -- Medication enddate
	compliant int4 NULL, --  Medication compliant
	reportedby varchar NULL, -- Medication reportedby
	medicationtypekey varchar NULL, -- Medication medicationtypekey
	monitoring varchar NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	isprescribedmedication bool NULL,
	medicationtype varchar NULL,
	prescribedduration varchar NULL,
	prescribedreason varchar NULL,
	ismedicationpsychotropic bool NULL, -- Is medication psychotropic information
	classification varchar NULL, -- diagnosis information
	diagnosis varchar NULL,
	uploadedfiles json NULL, -- If medic pshychotropic is renewal then true
	targetedsymptoms varchar NULL, -- Medication Targeted symptoms 
	targetedother varchar NULL, -- Medication Targeted symptoms other
	informedconsent varchar NULL, -- Medication informed consent
	renewal bool NULL,
	specifyfrequencyhour varchar NULL, -- To store the specify frequency hour
	specifyduration varchar NULL, -- To store the specify frequency hour
	otherspecifyduration varchar NULL, -- To store the other specifyduration data
	otherreason varchar NULL, -- If medic pshychotropic is Other Frequency 
	datemedicationstarted timestamp NULL, -- Date Medication Start 
	isprescribercheck bool NULL, -- Prescriber did not document
	compliantcomments varchar NULL, -- To store the compliant comments
	dateofrefill date NULL, -- To store date of refill date
	changeofdate date NULL, -- To store date of change of date
	CONSTRAINT pk_personmedicpshychotropic_history PRIMARY KEY (personmedichistoryid),
    CONSTRAINT fk_personmedicpshychotropic_history FOREIGN KEY (personmedicpshychotropicid) REFERENCES cjams.personmedicpshychotropic(personmedicpshychotropicid),
	CONSTRAINT fk_personmedicpshychotropic_hist_personid FOREIGN KEY (personid) REFERENCES cjams.person(personid)
);




COMMENT ON COLUMN cjams.personmedicpshychotropic_history.personmedichistoryid IS 'Primary Key';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.personmedicpshychotropicid IS 'foreign key';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.personid IS 'foreign key';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.medicationname IS 'Person Medication Name';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.medicationeffectivedate IS 'prescription effectivate date';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.medicationexpirationdate IS 'prescription Expiry date';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.frequency IS ' Medication frequency  ';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.lastdosetakendate IS ' Medication lastdosetakendate ';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.medicationcomments IS ' medicationcomments ';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.prescriptionreasontypekey IS 'Medication prescriptionreasontypekey ';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.informationsourcetypekey IS 'Medication informationsourcetypekey';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.activeflag IS 'Status of the record';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.startdate IS 'Medication start date';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.enddate IS 'Medication end date';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.ismedicationpsychotropic IS 'Is medication psychotropic information';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.classification IS 'diagnosis information';
COMMENT ON COLUMN cjams.personmedicpshychotropic_history.uploadedfiles IS 'to store document upload details';

