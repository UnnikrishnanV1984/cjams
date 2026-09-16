ALTER TABLE IF EXISTS cjams.crispcjamsflattenedinbound_iss DROP CONSTRAINT IF EXISTS pk_crispcjamsflattenedinbound_iss;
DROP TABLE IF EXISTS cjams.crispcjamsflattenedinbound_iss;

CREATE TABLE cjams.crispcjamsflattenedinbound_iss (
    crispcjamsflattenedinboundissid uuid NOT NULL DEFAULT gen_random_uuid(),
	crispcjamsflattenedinboundid uuid NULL,
	immunizationid varchar(250) NULL,
    personimmunizationconfigid uuid NULL,
    personimmunizationid uuid NULL,
    status varchar(50) NULL,
    crispinboundid uuid NULL,
    vaccinationdate timestamp NULL,
    lastupdateddt timestamp NULL,
    cvxcode varchar(50) NULL,
    dose varchar(50) NULL,
    agetype varchar(50) NULL,
    startdose int4 NULL,
    enddose int4 NULL,
    totaldose int4 NULL,
    currentdose int4 NULL,
    newdose int4 NULL,
    activeflag int4 NOT NULL DEFAULT 1,
    insertedby varchar(50) NOT NULL DEFAULT 'CRISP_INBOUND_INTERFACE'::character varying,
    insertedon timestamp NOT NULL DEFAULT now(),
    updatedby varchar(50) NOT NULL DEFAULT 'CRISP_INBOUND_INTERFACE'::character varying,
    updatedon timestamp NULL DEFAULT now(),
    clientid varchar NULL,
    batchlogid int8 NULL,
    personid uuid NULL,
    immunizationkey varchar(20) NULL,
    "comments" text NULL,	
	CONSTRAINT pk_crispcjamsflattenedinbound_iss PRIMARY KEY (crispcjamsflattenedinboundissid)
);


---Column comments

COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.crispcjamsflattenedinboundissid IS 'crispcjamsflattenedinbound_iss details stored in this table(primary key)';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.crispcjamsflattenedinboundid IS 'crispcjamsflattenedinbound table id';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.immunizationid IS 'immunization id';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.personimmunizationconfigid IS 'person immunization config id';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.personimmunizationid IS 'person immunization id';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.status IS 'INSERT-UPDATE status of the record';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.crispinboundid IS 'crisp inbound id';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.vaccinationdate IS 'vaccination date';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.lastupdateddt IS 'immunization date';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.cvxcode IS 'cvx code';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.dose IS 'dosage details';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.agetype IS 'age category of the person';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.startdose IS 'start dosage number';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.enddose IS 'end dosage number';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.totaldose IS 'total dosage number';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.currentdose IS 'current dosage number';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.newdose IS 'new dosage number';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.activeflag IS 'status of the record';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.insertedby IS 'user who created this record';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.insertedon IS 'record created date and time';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.updatedby IS 'user who last updated this record';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound_iss.updatedon IS 'record updated date and time';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.personid IS 'personid for the CRISP vaccine obtained from studentno.';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.immunizationkey IS 'immunizationkey derived from the cvx to cjams mapping';