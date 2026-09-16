-- expunge.investigationfinding_expunge definition

-- Drop table

-- DROP TABLE expunge.investigationfinding_expunge;

CREATE TABLE expunge.investigationfinding_expunge (
    investigationfindingexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- Unique identifier of this table (Primary Key)
	investigationfindingid uuid NOT NULL, -- Unique identifier of this table (Primary Key)
	investigationfindingtypekey varchar(15) NULL, -- Investigationfindingtypekey 
	personid uuid NULL, -- Personid (Foreign Key)
	activeflag int4 DEFAULT 1 NULL, -- Status of the record
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp DEFAULT now() NULL, -- Record updated date and time
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp DEFAULT now() NULL, -- Record created date and time
	effectivedate timestamp DEFAULT now() NOT NULL, -- Record valid from
	expirationdate timestamp NULL, -- Record inactive date
	old_id varchar(50) NULL, -- Used for migration purpose
	investigationmaltreatmentactorid uuid NULL, -- Investigationmaltreatmentactorid
	investigationallegationid uuid NULL, -- Investigationallegationid
	findingcomments text NULL, -- Findingcomments
	isharm int4 DEFAULT 0 NULL, -- Harm flag
	isharmsubstantial int4 DEFAULT 0 NULL, -- Harm substantial flag
	harmdesc text NULL, -- Harmdesc
	intentionalinjurydesc varchar NULL, -- Intentional injury Description
	omissiondesc text NULL, -- Omission Description
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
	fk_id varchar(50) NULL,
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
	finalfinding varchar(50) NULL,
	fk_r_id varchar NULL,
	fk_am_id varchar NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_investigationfinding_expunge PRIMARY KEY (investigationfindingexpungeid),
	CONSTRAINT fk_investigationfinding_expunge_investigationallegation FOREIGN KEY (investigationallegationid) REFERENCES cjams.investigationallegation(investigationallegationid),
	CONSTRAINT fk_investigationfinding_expunge_person FOREIGN KEY (personid) REFERENCES cjams.person(personid)
);
CREATE INDEX indx_investigationfinding_expunge_investigationallegationid ON expunge.investigationfinding_expunge USING btree (investigationallegationid);
CREATE INDEX indx_investigationfinding_expunge_investigationfindingtypekey ON expunge.investigationfinding_expunge USING btree (investigationfindingtypekey);

-- Column comments
COMMENT ON COLUMN expunge.investigationfinding_expunge.investigationfindingexpungeid IS 'Unique identifier of this table (Primary Key)';
COMMENT ON COLUMN expunge.investigationfinding_expunge.investigationfindingid IS 'Unique identifier of this table (Primary Key) for investigationfinding table';
COMMENT ON COLUMN expunge.investigationfinding_expunge.investigationfindingtypekey IS 'Investigationfindingtypekey ';
COMMENT ON COLUMN expunge.investigationfinding_expunge.personid IS 'Personid (Foreign Key)';
COMMENT ON COLUMN expunge.investigationfinding_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.investigationfinding_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.investigationfinding_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.investigationfinding_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.investigationfinding_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.investigationfinding_expunge.effectivedate IS 'Record valid from';
COMMENT ON COLUMN expunge.investigationfinding_expunge.expirationdate IS 'Record inactive date';
COMMENT ON COLUMN expunge.investigationfinding_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.investigationfinding_expunge.investigationmaltreatmentactorid IS 'Investigationmaltreatmentactorid';
COMMENT ON COLUMN expunge.investigationfinding_expunge.investigationallegationid IS 'Investigationallegationid';
COMMENT ON COLUMN expunge.investigationfinding_expunge.findingcomments IS 'Findingcomments';
COMMENT ON COLUMN expunge.investigationfinding_expunge.isharm IS 'Harm flag';
COMMENT ON COLUMN expunge.investigationfinding_expunge.isharmsubstantial IS 'Harm substantial flag';
COMMENT ON COLUMN expunge.investigationfinding_expunge.harmdesc IS 'Harmdesc';
COMMENT ON COLUMN expunge.investigationfinding_expunge.intentionalinjurydesc IS 'Intentional injury Description';
COMMENT ON COLUMN expunge.investigationfinding_expunge.omissiondesc IS 'Omission Description';
COMMENT ON COLUMN expunge.investigationfinding_expunge.isexpunged IS 'Flag to indicate the expunged record';