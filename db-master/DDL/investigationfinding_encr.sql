-- Drop table

-- DROP TABLE encr.investigationfinding_encr;

CREATE TABLE encr.investigationfinding_encr (
    investigationfindingencrid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
	investigationfindingid uuid NOT NULL,
	investigationfindingtypekey bytea NULL,
	personid uuid NULL,
	activeflag int4 NULL DEFAULT 1,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	effectivedate timestamp NOT NULL DEFAULT now(),
	expirationdate timestamp NULL,
	old_id varchar(50) NULL,
	investigationmaltreatmentactorid uuid NULL,
	investigationallegationid uuid NULL,
	findingcomments bytea NULL,
	isharm int4 NULL DEFAULT 0,
	isharmsubstantial int4 NULL DEFAULT 0,
	harmdesc bytea NULL,
	intentionalinjurydesc bytea NULL,
	omissiondesc bytea NULL,
	intakeserviceid uuid NULL,
	invsfindingjurisdiction varchar(50) NULL,
	invsfindingaddress varchar(50) NULL,
	investigationfindingdate timestamp NULL,
	socialhistorydesc varchar(250) NULL,
	familyhistorydesc varchar(250) NULL,
	educationalfactors varchar(250) NULL,
	psychiatricimportinfo bool NULL,
	psychiatricdesc varchar(250) NULL,
	financialimportinfo bool NULL,
	assetdetailsdesc varchar(250) NULL,
	legalinfopoa varchar(50) NULL,
	legalinforeppayee varchar(50) NULL,
	legalinfocourtinvolved varchar(50) NULL,
	legalinfodesc varchar(50) NULL,
	clentcapacitydesc varchar(50) NULL,
	reasonclosingdesc varchar(50) NULL,
	apsworkersigndate timestamp NULL,
	supervisorsigndate timestamp NULL,
	fk_id bytea NULL,
	investigationallegationactorid uuid NULL,
	victim_explanation varchar NULL,
	sibling_explanation varchar NULL,
	guardian_explanation varchar NULL,
	maltreator_explanation varchar NULL,
	med_assessmnts varchar NULL,
	expert_assessmnts varchar NULL,
	collateral_interviews varchar NULL,
	criminal_history_inv varchar NULL,
	home_conditions varchar NULL,
	finalfinding bytea NULL,
	fk_r_id bytea NULL,
	fk_am_id varchar NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_investigationfinding_encr PRIMARY KEY (investigationfindingencrid),
	CONSTRAINT fk_investigationfinding_encr_investigationallegation FOREIGN KEY (investigationallegationid) REFERENCES investigationallegation(investigationallegationid),
	CONSTRAINT fk_investigationfinding_encr_person FOREIGN KEY (personid) REFERENCES person(personid)
);
CREATE INDEX indx_investigationfinding_encr_investigationallegationid ON encr.investigationfinding_encr USING btree (investigationallegationid);
CREATE INDEX indx_investigationfinding_encr_investigationfindingtypekey ON encr.investigationfinding_encr USING btree (investigationfindingtypekey);
-- Column comments
COMMENT ON COLUMN encr.investigationfinding_encr.investigationfindingencrid IS 'Unique identifier of this encrypted table (Primary Key)';
COMMENT ON COLUMN encr.investigationfinding_encr.investigationfindingid IS 'Unique identifier of this table investigationfinding (Primary Key)';
COMMENT ON COLUMN encr.investigationfinding_encr.investigationfindingtypekey IS 'Investigationfindingtypekey ';
COMMENT ON COLUMN encr.investigationfinding_encr.personid IS 'Personid (Foreign Key)';
COMMENT ON COLUMN encr.investigationfinding_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.investigationfinding_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.investigationfinding_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.investigationfinding_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.investigationfinding_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.investigationfinding_encr.effectivedate IS 'Record valid from';
COMMENT ON COLUMN encr.investigationfinding_encr.expirationdate IS 'Record inactive date';
COMMENT ON COLUMN encr.investigationfinding_encr.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN encr.investigationfinding_encr.investigationmaltreatmentactorid IS 'Investigationmaltreatmentactorid';
COMMENT ON COLUMN encr.investigationfinding_encr.investigationallegationid IS 'Investigationallegationid';
COMMENT ON COLUMN encr.investigationfinding_encr.findingcomments IS 'Findingcomments';
COMMENT ON COLUMN encr.investigationfinding_encr.isharm IS 'Harm flag';
COMMENT ON COLUMN encr.investigationfinding_encr.isharmsubstantial IS 'Harm substantial flag';
COMMENT ON COLUMN encr.investigationfinding_encr.harmdesc IS 'Harmdesc';
COMMENT ON COLUMN encr.investigationfinding_encr.intentionalinjurydesc IS 'Intentional injury Description';
COMMENT ON COLUMN encr.investigationfinding_encr.omissiondesc IS 'Omission Description';


