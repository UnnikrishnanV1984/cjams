-- Drop table

-- DROP TABLE cjams.intakeservicerequestactor_history;

CREATE TABLE cjams.intakeservicerequestactor_history (
	intakeservicerequestactorhistoryid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),-- Intake actor details stored in this table(Primary Key) 
    intakeservicerequestactorid uuid NOT NULL,
	actorid uuid NOT NULL, 
	intakeservicerequestpersontypekey varchar(15) NULL, 
	rapersontypekey varchar(15) NULL, 
	insertedby varchar(50) NULL, 
	insertedon timestamp NULL DEFAULT now(), 
	updatedby varchar(50) NULL, 
	updatedon timestamp NULL, 
	expirationdate timestamp NULL, 
	"timestamp" bytea NULL, 
	intakeserviceid uuid NULL, 
	routingaddressid uuid NULL, 
	employeetypeid uuid NULL, 
	employeetypename varchar(50) NULL, 
	medicaideligibility bool NULL, 
	blockgranteligibility bool NULL, 
	livingarrangementtypekey varchar(50) NULL, 
	guardianname varchar(512) NULL, 
	guardianinfo varchar(126) NULL, 
	ramentalhealth bool NULL, 
	ramentalretarted bool NULL, 
	ramentalretartedtype varchar(50) NULL, 
	refusessn bool NULL, 
	refusedob bool NULL, 
	activeflag int4 NULL DEFAULT 1, 
	reported bool NULL DEFAULT false, 
	isprimary bool NULL DEFAULT false,
	personid uuid NULL, 
	old_id varchar(50) NULL, 
	ismaltreator bool NULL,
	rcprimaryroletypekey varchar(5) NULL,
	ncpspriorhistoryflag int4 NULL,
	householdnumber int4 NULL,
	ssnverifytypekey varchar(5) NULL,
	rchandicapflag int4 NULL,
	rchomelessflag int4 NULL,
	lvgarrangementtypekey varchar(5) NULL,
	livingprefixtypekey varchar(5) NULL,
	lvgfirstname varchar(20) NULL,
	lvgmiddlename varchar(20) NULL,
	lvglastname varchar(20) NULL,
	lvgsuffixtypekey varchar(5) NULL,
	lvgrelationshiptypekey varchar(5) NULL,
	lvgcomments varchar(500) NULL,
	rchouseholdflag int4 NULL,
	rcchildflag int4 NULL,
	nonparticipatingflag int4 NULL,
	householdheadflag int4 NULL,
	rcinsertedon timestamp NULL,
	rcinsertedby varchar(10) NULL,
	rcupdatedon timestamp NULL,
	rcupdatedby varchar(10) NULL,
	rcactiveflag int4 NULL DEFAULT 1,
	livingwith varchar(500) NULL,
	rcreporteranonymousflag int4 NULL,
	rcreporternoletterflag int4 NULL,
	clientflag int4 NULL,
	rcexpungementflag int4 NULL,
	rcdatavalidflag int4 NULL,
	rcclientmergeid int4 NULL,
	arclientid int4 NULL,
	arsummaryid int4 NULL,
	altrespclientid int4 NULL,
	participatingchildflag int4 NULL,
	aractiveflag int4 NULL DEFAULT 1,
	screeningpersonid int4 NULL,
	prexpungementflag int4 NULL,
	prdatavalidflag int4 NULL,
	prinsertedby varchar(10) NULL,
	prupdatedby varchar(10) NULL,
	practiveflag int4 NULL DEFAULT 1,
	referralclientid int4 NULL,
	caseclientid int4 NULL,
	crexpungementflag int4 NULL,
	crdatavalidflag int4 NULL,
	crinsertedby varchar(10) NULL,
	crupdatedby varchar(10) NULL,
	sphouseholdmemberflag int4 NULL,
	spchildflag int4 NULL,
	spreporteranonymousflag int4 NULL,
	spreporternoletterflag int4 NULL,
	spexpungementflag int4 NULL,
	fetalalcoholspctrmdisordflag int4 NULL,
	drugexposednewbornflag int4 NULL,
	probationsearchconductedflag int4 NULL,
	sexoffenderregisteredflag int4 NULL,
	otherdrugs int4 NULL,
	unknownreporterflag int4 NULL,
	spproviderid int4 NULL,
	fk_id varchar(50) NULL,
	isvictim int4 NULL,
	servicecaseid uuid NULL, 
	fk_cl_id varchar(50) NULL,
	intakenumber varchar NULL,
	isheadofhousehold bool NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	objectid varchar(50) NULL,
	objecttype varchar(50) NULL,
    CONSTRAINT pk_intakeservicerequestactorhistory PRIMARY KEY (intakeservicerequestactorhistoryid),
	CONSTRAINT pk_intakeservicerequestactorhis FOREIGN KEY (intakeservicerequestactorid) REFERENCES intakeservicerequestactor(intakeservicerequestactorid)
);

COMMENT ON COLUMN cjams.intakeservicerequestactor_history.intakeservicerequestactorhistoryid IS 'Table primary key UUID';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.intakeservicerequestactorid IS 'Foreign key from intakeservicerequestactor';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.actorid IS 'Unique id link for intakeservicerequestactor with actor table';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.intakeservicerequestpersontypekey IS 'Person Role type Key';;
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.expirationdate IS 'Record will expire on this date';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.intakeserviceid IS 'Record to link if person with cps case';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.activeflag IS 'Flag to check if record is active or soft deleted';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.isprimary IS 'This will define the primary role for the person in that particular intake or case';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.personid IS 'Personid is the link thats established with the person table';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.refusessn IS 'This flag is always false';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.refusedob IS 'This flag is always false';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.reported IS 'Role reported flag';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.old_id IS 'Record related old id ';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.ismaltreator IS 'if the person role has maltreator';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.fetalalcoholspctrmdisordflag IS 'flag to determine if child is fetal ';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.drugexposednewbornflag IS 'drugs exposed new born flag';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.ssnverifytypekey IS 'ssn verification key';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.probationsearchconductedflag IS 'Probation search conducted flag';;
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.sexoffenderregisteredflag IS 'Sex offender registery checked flag';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.otherdrugs IS 'Any other drugs flag';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.unknownreporterflag IS 'Unknown reported person flag';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.intakenumber IS 'Link withe the intake number';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.isheadofhousehold IS 'if the person is head of household';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.etl_userid IS 'migrated record entry details id';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.etl_load_date IS 'migrated record entry details date';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.objectid IS 'Person linked to any case id';
COMMENT ON COLUMN cjams.intakeservicerequestactor_history.objecttype IS 'person linked to case type';