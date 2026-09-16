CREATE TABLE cjams.intakeservicerequestactor_hist (
	intakeservicerequestactorid uuid NOT NULL DEFAULT gen_random_uuid(), -- Intake actor details stored in this table(Primary Key)
	actorid uuid NOT NULL, -- Intake actor id(Foreign Key)
	intakeservicerequestpersontypekey varchar(15) NULL, -- Persontype key
	rapersontypekey varchar(15) NULL, -- Reported adult persontype (Foreign key)
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp NULL DEFAULT now(), -- Record created date and time
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NULL, -- Record updated date and time
	expirationdate timestamp NULL, -- Record inactive date
	"timestamp" bytea NULL, -- Timestamp
	intakeserviceid uuid NULL, -- Intakeserviceid (Foreign key)
	routingaddressid uuid NULL, -- Routingaddress (Foreign key)
	employeetypeid uuid NULL, -- Employee type (Foreign key)
	employeetypename varchar(50) NULL, -- Employee name
	medicaideligibility bool NULL, -- Medicaideligibility
	blockgranteligibility bool NULL, -- Blockgranteligibility
	livingarrangementtypekey varchar(50) NULL, -- Livingarrangementtype (Foreign key)
	guardianname varchar(512) NULL, -- Guardianname
	guardianinfo varchar(126) NULL, -- Gardian information
	ramentalhealth bool NULL, -- Report adult health
	ramentalretarted bool NULL, -- Report adult retarted
	ramentalretartedtype varchar(50) NULL, -- Report adult mental retarted type
	refusessn bool NULL, -- Intake actor SSN
	refusedob bool NULL, -- Intake actor Date of Birth
	activeflag int4 NULL DEFAULT 1, -- Status of the record
	reported bool NULL DEFAULT false, -- Reported 
	isprimary bool NULL DEFAULT false, -- Primary role
	personid uuid NULL, -- personid
	old_id varchar(50) NULL, -- Used for migration purpose
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
	servicecaseid uuid NULL, -- Servicecase primary key
	fk_cl_id varchar(50) NULL,
	intakenumber varchar NULL,
	isheadofhousehold bool NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL
);