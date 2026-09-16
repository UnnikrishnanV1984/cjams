ALTER TABLE IF EXISTS cjams.crispcjamsflattenedinbound DROP CONSTRAINT IF EXISTS pk_crispcjamsflattenedinbound;
DROP TABLE IF EXISTS cjams.crispcjamsflattenedinbound;

CREATE TABLE cjams.crispcjamsflattenedinbound (
	crispcjamsflattenedinboundid uuid NOT NULL DEFAULT gen_random_uuid(),
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
	CONSTRAINT pk_crispcjamsflattenedinbound PRIMARY KEY (crispcjamsflattenedinboundid)
);


---Column comments

COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.crispcjamsflattenedinboundid IS 'crispcjamsflattenedinbound details stored in this table(primary key)';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.immunizationid IS 'immunization id';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.personimmunizationconfigid IS 'person immunization config id';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.personimmunizationid IS 'person immunization id';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.status IS 'INSERT-UPDATE status of the record';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.crispinboundid IS 'crisp inbound id';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.vaccinationdate IS 'vaccination date';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.lastupdateddt IS 'immunization date';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.cvxcode IS 'cvx code';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.dose IS 'dosage details';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.agetype IS 'age category of the person';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.startdose IS 'start dosage number';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.enddose IS 'end dosage number';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.totaldose IS 'total dosage number';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.currentdose IS 'current dosage number';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.newdose IS 'new dosage number';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.activeflag IS 'status of the record';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.insertedby IS 'user who created this record';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.insertedon IS 'record created date and time';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.updatedby IS 'user who last updated this record';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.updatedon IS 'record updated date and time';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.personid IS 'personid for the CRISP vaccine obtained from studentno.';
COMMENT ON COLUMN cjams.crispcjamsflattenedinbound.immunizationkey IS 'immunizationkey derived from the cvx to cjams mapping';